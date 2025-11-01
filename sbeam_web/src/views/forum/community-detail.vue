<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import navigaton from '@/components/share/navigaton.vue'
import kobeImg from '@/assets/img/kobe.png'

const BACKEND = 'http://localhost:8080'
const route = useRoute()
const router = useRouter()

const community = ref<any>({
  id: 0,
  name: '',
  description: '',
  img: kobeImg,
  posts: [],
})

const showPostInput = ref(false)
const newPostTitle = ref('')
const newPostAuthor = ref('页友')
const newPostContent = ref('')

const fetchCommunityAndPosts = async () => {
  try {
    const id = Number(route.query.id || route.params.id || 1)
    const resComm = await fetch(`${BACKEND}/community/id?id=${id}`)
    const comm = await resComm.json()
    community.value.id = comm.communityId
    community.value.name = comm.communityName
    community.value.description = comm.communityDescription
    community.value.img = kobeImg

    const resPosts = await fetch(`${BACKEND}/mygo`)
    const posts = await resPosts.json()

    // 调试信息
    console.log('所有帖子:', posts)
    console.log('当前社区ID:', comm.communityId, '类型:', typeof comm.communityId)

    // 临时测试：显示所有帖子（不过滤）
    community.value.posts = posts
      // .filter((p: any) => {
      //   // 确保类型一致性
      //   const postCommunityId = String(p.communityId)
      //   const currentCommunityId = String(comm.communityId)
      //   console.log(`比较: ${postCommunityId} === ${currentCommunityId}`, postCommunityId === currentCommunityId)
      //   return postCommunityId === currentCommunityId
      // })
      .map((p: any) => ({
        id: p.postId,
        title: p.postTitle,
        author: p.userId ? `用户#${p.userId}` : '匿名',
        time: p.createdAt ? new Date(p.createdAt).toLocaleString() : new Date().toLocaleString(),
        replies: p.likeCount || 0,
      }))
      .sort((a: any, b: any) => new Date(b.time).getTime() - new Date(a.time).getTime()) // 按时间倒序

    console.log('过滤后的帖子:', community.value.posts)
  } catch (err) {
    console.error('加载社区/帖子失败', err)
  }
}

onMounted(fetchCommunityAndPosts)

const addPost = async () => {
  if (newPostTitle.value.trim() === '') {
    alert('请输入帖子标题')
    return
  }

  try {
    // 构建符合后端实体类的请求体
    const postData = {
      communityId: String(community.value.id),
      userId: null, // 或者从用户登录信息获取
      postTitle: newPostTitle.value,
      postContent: newPostContent.value,
      parentPostId: null, // 新帖子没有父帖
      likeCount: '0',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      status: '1', // 假设 1 表示正常状态
      version: '1'
    }

    console.log('发送的帖子数据:', postData)

    // 调用后端 POST 接口
    const response = await fetch(`${BACKEND}/mygo`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(postData)
    })

    if (response.ok) {
      console.log('发帖成功，重新获取帖子列表')
      // 发帖成功后重新获取帖子列表
      await fetchCommunityAndPosts()

      // 清空输入框
      newPostTitle.value = ''
      newPostContent.value = ''
      newPostAuthor.value = '页友'
      showPostInput.value = false

      alert('发帖成功!')
    } else {
      const errorText = await response.text()
      console.error('后端返回错误:', errorText)
      throw new Error('发帖失败')
    }
  } catch (err) {
    console.error('发帖出错:', err)
    alert('发帖失败，请重试')
  }
}

// 点击帖子跳转详情
const goToPostDetail = (id: number) => {
  router.push({ path: '/post-detail', query: { id } })
}
</script>

<template>
  <navigaton />

  <main class="community-detail-main">
    <div class="community-header">
      <img :src="community.img" alt="社区头像" class="community-avatar" />
      <h1>{{ community.name }}</h1>
      <p>{{ community.description }}</p>
    </div>

    <div class="post-actions">
      <button @click="showPostInput = !showPostInput">
        {{ showPostInput ? '取消' : '发帖' }}
      </button>

      <div v-if="showPostInput" class="post-input">
        <input v-model="newPostTitle" type="text" placeholder="请输入帖子标题" />
        <input v-model="newPostAuthor" type="text" placeholder="作者名" />
        <textarea v-model="newPostContent" placeholder="帖子内容" class="big"></textarea>
        <button @click="addPost">提交</button>
      </div>
    </div>

    <div class="posts-list">
      <div class="post-item-header">
        <span class="title">帖子标题</span>
        <span class="author">作者</span>
        <span class="time">时间</span>
        <span class="replies">回复</span>
      </div>
      <div v-for="post in community.posts" :key="post.id" class="post-item" @click="goToPostDetail(post.id)">
        <span class="title">{{ post.title }}</span>
        <span class="author">{{ post.author }}</span>
        <span class="time">{{ post.time }}</span>
        <span class="replies">{{ post.replies }}</span>
      </div>

      <!-- 如果没有帖子，显示提示 -->
      <div v-if="community.posts.length === 0" style="padding: 20px; text-align: center; color: #999;">
        暂无帖子，快来发第一帖吧！
      </div>
    </div>
  </main>
</template>

<style scoped>
/* 整体布局 */
.community-detail-main {
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 20px;
  background: #f7f8fa;
  min-height: 100vh;
  font-family: "Microsoft YaHei", "Segoe UI", sans-serif;
}

/* 社区头部 */
.community-header {
  background: #fff;
  border-radius: 18px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  text-align: center;
  padding: 30px 20px;
  margin-bottom: 30px;
  transition: transform 0.25s ease;
}

.community-header:hover {
  transform: translateY(-3px);
}

.community-avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  border: 4px solid #e6e6e6;
  object-fit: cover;
  margin-bottom: 15px;
}

.community-header h1 {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 8px;
  color: #222;
}

.community-header p {
  font-size: 15px;
  color: #555;
  line-height: 1.6;
}

/* 发帖区域 */
.post-actions {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  margin-bottom: 25px;
}

.post-actions button {
  background: #409eff;
  color: white;
  border: none;
  padding: 8px 18px;
  border-radius: 6px;
  font-size: 15px;
  cursor: pointer;
  transition: background 0.2s;
}

.post-actions button:hover {
  background: #66b1ff;
}

/* 发帖输入框 */
.post-input {
  margin-top: 18px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.post-input input,
.post-input textarea {
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 10px;
  font-size: 14px;
  transition: border-color 0.2s;
}

.post-input input:focus,
.post-input textarea:focus {
  border-color: #409eff;
  outline: none;
}

.post-input textarea.big {
  min-height: 120px;
  resize: vertical;
}

.post-input button {
  align-self: flex-end;
  background: #67c23a;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.2s;
}

.post-input button:hover {
  background: #85ce61;
}

/* 帖子列表 */
.posts-list {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  overflow: hidden;
}

/* 帖子表头 */
.post-item-header {
  display: grid;
  grid-template-columns: 4fr 1fr 2fr 1fr;
  background: #f1f3f5;
  color: #333;
  font-weight: 600;
  padding: 12px 18px;
  border-bottom: 1px solid #ddd;
}

/* 帖子行 */
.post-item {
  display: grid;
  grid-template-columns: 4fr 1fr 2fr 1fr;
  padding: 12px 18px;
  border-bottom: 1px solid #eee;
  cursor: pointer;
  transition: background 0.2s, transform 0.1s;
}

.post-item:hover {
  background-color: #eef8f3;
  transform: translateX(4px);
}

/* 各列样式 */
.post-item span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

.post-item .title {
  color: #222;
  font-weight: 500;
}

.post-item .author {
  color: #666;
  text-align: center;
}

.post-item .time {
  color: #888;
  text-align: center;
}

.post-item .replies {
  color: #409eff;
  text-align: right;
}

/* 空状态提示 */
.posts-list>div:last-child {
  padding: 20px;
  text-align: center;
  color: #999;
  font-size: 14px;
}
</style>
