<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import navigaton from '@/components/share/navigaton.vue';
import kobeImg from '@/assets/img/kobe.png';

const BACKEND = 'http://localhost:8080'; 

const route = useRoute();
const community = ref<any>({
  id: 0,
  name: '',
  description: '',
  img: kobeImg,
  posts: [],
});

// 发帖输入控制
const showPostInput = ref(false);
const newPostTitle = ref('');
const newPostAuthor = ref('页友');

const fetchCommunityAndPosts = async () => {
  try {
    const id = Number(route.query.id || route.params.id || 1);
    // 获取社区详情
    const resComm = await fetch(`${BACKEND}/community/id?id=${id}`);
    const comm = await resComm.json();
    community.value.id = comm.communityId;
    community.value.name = comm.communityName;
    community.value.description = comm.communityDescription;
    community.value.img = kobeImg;

    // 获取所有帖子并过滤该社区的帖子
    const resPosts = await fetch(`${BACKEND}/post`);
    const posts = await resPosts.json();
    community.value.posts = posts
      .filter((p: any) => p.communityId === comm.communityId)
      .map((p: any) => ({
        id: p.postId,
        title: p.postTitle,
        author: p.userId ? `用户#${p.userId}` : '匿名',
        time: p.createdAt || new Date().toLocaleString(),
        replies: p.likeCount || 0,
      }));
  } catch (err) {
    console.error('加载社区/帖子失败', err);
    // 保持原有模拟数据以防页面空白
    community.value = {
      id: 1,
      name: 'abstract',
      description: '讲文明，树新风，6324向前冲',
      img: kobeImg,
      posts: [
        { id: 1, title: '太阳升起,我已复活', author: '古德莉莉安', time: '2025-09-28 10:00', replies: 6324 },
      ],
    };
  }
};

onMounted(fetchCommunityAndPosts);

const addPost = () => {
  if (newPostTitle.value.trim() === '') return;
  community.value.posts.unshift({
    id: Date.now(),
    title: newPostTitle.value,
    author: newPostAuthor.value,
    time: new Date().toLocaleString(),
    replies: 0,
  });
  newPostTitle.value = '';
  showPostInput.value = false;
};
</script>

<template>
  <navigaton />

  <main class="community-detail-main">
    <!-- 社区头部 -->
    <div class="community-header">
      <img :src="community.img" alt="社区头像" class="community-avatar" />
      <h1>{{ community.name }}</h1>
      <p>{{ community.description }}</p>
    </div>

    <!-- 发帖按钮 -->
    <div class="post-actions">
      <button @click="showPostInput = !showPostInput">
        {{ showPostInput ? '取消' : '发帖' }}
      </button>

      <div v-if="showPostInput" class="post-input">
        <input v-model="newPostTitle" type="text" placeholder="请输入帖子标题" />
        <input v-model="newPostAuthor" type="text" placeholder="作者名" />
        <textarea placeholder="帖子内容" class="big"></textarea>
        <button @click="addPost">提交</button>
      </div>
    </div>

    <!-- 帖子列表 -->
    <div class="posts-list">
      <div class="post-item-header">
        <span class="title">帖子标题</span>
        <span class="author">作者</span>
        <span class="time">时间</span>
        <span class="replies">回复</span>
      </div>
      <div v-for="post in community.posts" :key="post.id" class="post-item">
        <span class="title">{{ post.title }}</span>
        <span class="author">{{ post.author }}</span>
        <span class="time">{{ post.time }}</span>
        <span class="replies">{{ post.replies }}</span>
      </div>
    </div>
  </main>
</template>

<style scoped>
.post-input textarea.big {
  width: 100%;
  /* 或者固定宽度，如 600px */
  min-height: 200px;
  /* 初始高度 */
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  resize: vertical;
  /* 允许上下拉伸 */
  font-size: 16px;
  line-height: 1.5;
  box-sizing: border-box;
}

.community-detail-main {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
  font-family: "Segoe UI", Arial, sans-serif;
}

/* 社区头部 */
.community-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-bottom: 24px;
}

.community-avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 12px;
}

.community-header h1 {
  margin: 0 0 6px;
  font-size: 24px;
  color: #333;
}

.community-header p {
  margin: 0;
  font-size: 14px;
  color: #666;
}

/* 发帖区域 */
.post-actions {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin-bottom: 20px;
  gap: 8px;
}

.post-actions button {
  padding: 6px 12px;
  background-color: #42b983;
  color: #fff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.post-actions button:hover {
  background-color: #369870;
}

.post-input {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-top: 8px;
}

.post-input input {
  padding: 6px 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  width: 100%;
  box-sizing: border-box;
}

.post-input button {
  align-self: flex-start;
  padding: 6px 12px;
  background-color: #42b983;
  color: #fff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.post-input button:hover {
  background-color: #369870;
}

/* 帖子列表 */
.posts-list {
  width: 100%;
  border-top: 1px solid #ccc;
}

/* 表头 */
.post-item-header {
  display: grid;
  grid-template-columns: 4fr 2fr 2fr 1fr;
  font-weight: bold;
  background-color: #e0e0e0;
  padding: 12px;
  color: #333;
  border-bottom: 1px solid #ccc;
}

/* 帖子行 */
.post-item {
  display: grid;
  grid-template-columns: 4fr 2fr 2fr 1fr;
  padding: 12px;
  border-bottom: 1px solid #eee;
  align-items: center;
  background-color: #f9f9f9;
}

/* 文本样式 */
.post-item .title {
  font-size: 16px;
  color: #42b983;
}

.post-item .author,
.post-item .time,
.post-item .replies {
  font-size: 14px;
  color: #666;
  text-align: center;
}
</style>
