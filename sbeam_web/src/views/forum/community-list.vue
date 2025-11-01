<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import navigaton from '@/components/share/navigaton.vue'
import kobeImg from '@/assets/img/kobe.png'

const BACKEND = 'http://localhost:8080'
const router = useRouter()

const communities = ref<any[]>([])

const fetchData = async () => {
  try {
    const resComm = await fetch(`${BACKEND}/community`)
    const commList = await resComm.json()

    const resPosts = await fetch(`${BACKEND}/mygo`)
    const postList = await resPosts.json()

    communities.value = commList.map((c: any) => {
      const posts = postList
        .filter((p: any) => p.communityId === c.communityId)
        .map((p: any) => ({
          id: p.postId,
          title: p.postTitle,
          author: p.userId ? `用户#${p.userId}` : '页友',
        }))
      return {
        id: c.communityId,
        name: c.communityName,
        description: c.communityDescription,
        img: kobeImg,
        posts,
      }
    })
  } catch (err) {
    console.error('加载社区数据失败', err)
  }
}

onMounted(fetchData)

// 点击跳转到社区详情页
const goToCommunity = (id: number) => {
  router.push({ path: '/community-detail', query: { id } })
}

// 点击跳转到帖子详情页（可选）
const goToPost = (id: number) => {
  router.push({ path: '/post-detail', query: { id } })
}
</script>

<template>
  <navigaton />

  <main class="community-main">
    <h1>社区主页</h1>

    <div class="community-list">
      <div v-for="community in communities" :key="community.id" class="community-card"
        @click="goToCommunity(community.id)">
        <!-- 社区卡片 -->
        <div class="community-header">
          <img :src="community.img" alt="社区头像" />
          <h2>{{ community.name }}</h2>
          <p>{{ community.description }}</p>
        </div>

        <!-- 帖子列表 -->
        <div class="community-posts">
          <h3>热门帖子</h3>
          <div v-for="post in community.posts" :key="post.id" class="post-card" @click.stop="goToPost(post.id)">
            <p class="post-title">{{ post.title }}</p>
            <p class="post-author">作者：{{ post.author }}</p>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
/* 页面整体 */
.community-main {
  max-width: 1100px;
  margin: 0 auto;
  padding: 40px 20px;
  font-family: "Microsoft YaHei", "Segoe UI", sans-serif;
  background: #f7f8fa;
  min-height: 100vh;
}

h1 {
  font-size: 32px;
  font-weight: 700;
  color: #222;
  margin-bottom: 30px;
  text-align: center;
}

/* 社区列表布局 */
.community-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 28px;
}

/* 社区卡片 */
.community-card {
  background: #fff;
  border-radius: 18px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.25s ease;
  padding-bottom: 16px;
}

.community-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

/* 卡片头部 */
.community-header {
  text-align: center;
  padding: 24px 18px 12px;
}

.community-header img {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 12px;
  border: 3px solid #eee;
}

.community-header h2 {
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin: 8px 0;
}

.community-header p {
  font-size: 14px;
  color: #666;
  line-height: 1.5;
  margin: 0;
}

/* 帖子列表区域 */
.community-posts {
  margin-top: 16px;
  padding: 0 20px;
}

.community-posts h3 {
  font-size: 16px;
  font-weight: 600;
  color: #444;
  margin-bottom: 10px;
  border-left: 4px solid #409eff;
  padding-left: 8px;
}

/* 单个帖子卡片 */
.post-card {
  background: #f8fafc;
  border-radius: 10px;
  padding: 10px 14px;
  margin-bottom: 10px;
  transition: background 0.2s ease, transform 0.2s ease;
}

.post-card:hover {
  background: #e9f3ff;
  transform: translateX(4px);
}

.post-title {
  font-size: 15px;
  font-weight: 500;
  color: #222;
  margin-bottom: 4px;
}

.post-author {
  font-size: 13px;
  color: #777;
}
</style>
