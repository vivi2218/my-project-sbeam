<script setup lang="ts">
import { ref } from 'vue';
import navigaton from '@/components/share/navigaton.vue';
import kobeImg from '@/assets/img/kobe.png';

// 模拟社区数据
const community = ref({
  id: 1,
  name: 'abstract',
  description: '讲文明，树新风，6324向前冲',
  img: kobeImg,
  posts: [
    { id: 1, title: '太阳升起,我已复活', author: '古德莉莉安', time: '2025-09-28 10:00', replies: 6324 },
    { id: 2, title: '基础建设之张妈下楼梯', author: '古卫兵', time: '2025-09-28 10:00', replies: 12 },
    { id: 3, title: '新家在哪', author: '坏心的旅行家', time: '2025-09-27 18:30', replies: 8 },
    { id: 4, title: '这次感觉是真的散了', author: '老面孔', time: '2025-09-26 15:20', replies: 5 },
    { id: 5, title: '回顾经典', author: '维尼', time: '2025-09-26 15:20', replies: 5 }
  ],
});

// 控制发帖输入框显示
const showPostInput = ref(false);
const newPostTitle = ref('');
const newPostAuthor = ref('页友');

// 提交新帖子
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
