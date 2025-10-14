<script setup lang="ts">
import { ref, onMounted } from 'vue';
import navigaton from '@/components/share/navigaton.vue';
import kobeImg from '@/assets/img/kobe.png';

const BACKEND = 'http://localhost:8080'; // 如需更改端口，请修改此处

const communities = ref<any[]>([]);

const fetchData = async () => {
  try {
    // 获取社区列表
    const resComm = await fetch(`${BACKEND}/community`);
    const commList = await resComm.json();

    // 获取所有帖子并按 communityId 分组
    const resPosts = await fetch(`${BACKEND}/post`);
    const postList = await resPosts.json();

    // 将后端字段映射为前端展示需要的字段
    communities.value = commList.map((c: any) => {
      const posts = postList
        .filter((p: any) => p.communityId === c.communityId)
        .map((p: any) => ({
          id: p.postId,
          title: p.postTitle,
          author: p.userId ? `用户#${p.userId}` : '匿名',
        }));
      return {
        id: c.communityId,
        name: c.communityName,
        description: c.communityDescription,
        img: kobeImg,
        posts,
      };
    });
  } catch (err) {
    console.error('加载社区数据失败', err);
    // 回退到本地示例数据，避免页面空白（可选）
    communities.value = [
      {
        id: 1,
        name: '抽象tv',
        description: '很抱歉，没有找到相关内容',
        img: kobeImg,
        posts: [
          { id: 1, title: '很抱歉，没有找到相关内容', author: '李赣' },
          { id: 2, title: '很抱歉，没有找到相关内容', author: '孙笑川' },
        ],
      },
    ];
  }
};

onMounted(fetchData);
</script>

<template>
  <navigaton />

  <main class="community-main">
    <h1>社区主页</h1>

    <div class="community-list">
      <div v-for="community in communities" :key="community.id" class="community-card">

        <!-- 头像 + 名称 + 描述 -->
        <div class="community-header">
          <img :src="community.img" alt="社区头像" />
          <h2>{{ community.name }}</h2>
          <p>{{ community.description }}</p>
        </div>

        <!-- 帖子列表 -->
        <div class="community-posts">
          <h3>热门帖子</h3>
          <div v-for="post in community.posts" :key="post.id" class="post-card">
            <p class="post-title">{{ post.title }}</p>
            <p class="post-author">作者：{{ post.author }}</p>
          </div>
        </div>

      </div>
    </div>
  </main>
</template>

<style scoped>
.community-main {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  font-family: "Segoe UI", Arial, sans-serif;
}

/* 社区卡片 */
.community-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.community-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  padding: 16px;
}

/* 头像 + 名称 + 描述，上下排列 */
.community-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 8px;
  margin-bottom: 16px;
  /* background-color: #42b983; */
}

.community-header img {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
}

.community-header h2 {
  margin: 0;
  font-size: 22px;
  color: #333;
}

.community-header p {
  margin: 0;
  font-size: 14px;
  color: #666;
}

/* 帖子列表 */
.community-posts h3 {
  font-size: 16px;
  margin-bottom: 8px;
  color: #42b983;
}

.post-card {
  display: flex;
  flex-direction: column;
  width: 800px;
  padding: 10px 12px;
  margin-bottom: 6px;
  background-color: #f5f5f5;
  border-radius: 6px;
  transition: background 0.2s;
}

.post-card:hover {
  background-color: #e0e0e0;
}

.post-title {
  font-size: 14px;
  font-weight: 600;
  color: #333;
  margin: 0 0 2px;
}

.post-author {
  font-size: 12px;
  color: #777;
  margin: 0;
}
</style>
