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
          author: p.userId ? `用户#${p.userId}` : '匿名',
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
      <div
        v-for="community in communities"
        :key="community.id"
        class="community-card"
        @click="goToCommunity(community.id)"
      >
        <!-- 社区卡片 -->
        <div class="community-header">
          <img :src="community.img" alt="社区头像" />
          <h2>{{ community.name }}</h2>
          <p>{{ community.description }}</p>
        </div>

        <!-- 帖子列表 -->
        <div class="community-posts">
          <h3>热门帖子</h3>
          <div
            v-for="post in community.posts"
            :key="post.id"
            class="post-card"
            @click.stop="goToPost(post.id)"
          >
            <p class="post-title">{{ post.title }}</p>
            <p class="post-author">作者：{{ post.author }}</p>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
.community-card {
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}
.community-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}
.post-card {
  cursor: pointer;
}
</style>
