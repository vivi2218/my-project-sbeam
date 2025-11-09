<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted, onUnmounted, nextTick, watch } from 'vue'
import { useRouter } from 'vue-router'

// 新增：社区相关响应式数据
const recommendedCommunities = ref<any[]>([]) // 推荐的社区
const communityPosts = ref<Map<string, any[]>>(new Map()) // 存储每个社区的帖子
// 点击跳转到社区详情页
const goToCommunity = (communityName: string) => {
  // 这里假设通过社区名称跳转，实际项目可能需要社区ID
  router.push({ path: `/community/${encodeURIComponent(communityName)}` })
}

// 获取社区帖子数据
const fetchCommunityPosts = (communityName: string) => {
  return axios
    .get('http://localhost:8080/community/posts', {
      params: { communityName },
    })
    .then((response) => {
      return response.data
    })
    .catch((error) => {
      console.error(`获取${communityName}社区帖子失败:`, error)
      return []
    })
}

const router = useRouter()
const goGameDetail = (id: number) => {
  router.push({ name: 'game-detail', params: { id } })
}

// 从 localStorage 获取用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const hotItems = ref<any[]>([])

// 创建响应式的 displayItems 用于显示
const displayItems = ref<any[]>([])

// 获取推荐数据
axios
  .get('http://localhost:8080/game/get-recommendations', {
    params: { userId: user.userId },
  })
  .then((response) => {
    console.log('推荐数据:', response.data)
    const { recommended_games, recommended_posts } = response.data

    // 处理推荐游戏
    const getGameDetails = (gameId: number) => {
      return axios
        .get(`http://localhost:8080/game/details/${gameId}`)
        .then((response) => {
          const game = response.data
          return {
            gameId: game.data.gameId,
            gameName: game.data.gameName,
            mainImageUrl: game.data.mainImageUrl,
            gameDescription: game.data.gameProfile?.gameDescription,
          }
        })
        .catch((error) => {
          console.error(`获取游戏${gameId}详情失败:`, error)
          return null
        })
    }

    // 批量请求游戏详情
    const gameDetailsPromises = recommended_games.map((gameId: number) => getGameDetails(gameId))
    Promise.all(gameDetailsPromises)
      .then((allGameDetails) => {
        hotItems.value = allGameDetails.filter(Boolean)
      })
      .catch((error) => {
        console.error('获取游戏详情失败:', error)
      })

    // 处理推荐社区
    recommendedCommunities.value = recommended_posts
    // 为每个推荐社区获取帖子
    recommended_posts.forEach((community: any) => {
      fetchCommunityPosts(community.communityName).then((posts) => {
        communityPosts.value.set(community.communityName, posts)
      })
    })
  })
  .catch((error) => {
    console.error('获取推荐失败:', error)
  })

// 游戏轮播相关逻辑
watch(hotItems, () => {
  displayItems.value = [...hotItems.value, ...hotItems.value.slice(0, 6)]
})

const visibleCount = 4 // 调整一次显示数量，适配更宽的卡片
const itemWidth = 280 // 增加卡片宽度
const transitionTime = 800 // 加快过渡动画

const currentIndex = ref(0)
let timer: number | undefined
const isTransitioning = ref(true)

const startScroll = () => {
  timer = window.setInterval(() => {
    nextTick(() => {
      currentIndex.value++
      isTransitioning.value = true
    })
  }, 3000) // 延长滚动间隔
}

const handleTransitionEnd = () => {
  if (currentIndex.value >= hotItems.value.length) {
    isTransitioning.value = false
    currentIndex.value = 0
  }
}

onMounted(() => startScroll())
onUnmounted(() => {
  if (timer) clearInterval(timer)
})

// 备用图片路径
const defaultImage = '/gameimg/kemomimi.jpg'
const handleImageError = (event) => {
  event.target.src = defaultImage
}
</script>

<template>
  <div class="home-view">
    <div class="header-banner">
      <span class="banner-text">欢迎来到Sbeam</span>
      <br />
      <img src="/cyber.png" alt="Cyber" class="banner-image" />
    </div>

    <section class="recommendations">
      <h2 class="section-title">根据您的喜好推荐</h2>
      <div class="like-container">
        <div
          class="like-track"
          :style="{
            transform: `translateX(-${currentIndex * itemWidth}px)`,
            transition: isTransitioning ? `transform ${transitionTime}ms ease-out` : 'none',
          }"
          @transitionend="handleTransitionEnd"
        >
          <div class="game-card" v-for="(item, index) in displayItems" :key="index">
            <div class="game-visual">
              <img
                :src="`/gameimg/${item.gameId}.jpg`"
                alt="Game Cover"
                @error="handleImageError"
                class="game-image"
                @click="goGameDetail(item.gameId)"
              />
            </div>
            <div class="game-info">
              <h3 class="game-name">{{ item.gameName }}</h3>
              <p class="game-description">{{ item.gameDescription || '暂无游戏描述' }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- 社区中的新内容区域 -->
    <section class="community-section">
      <h2 class="section-title">社区中的新内容</h2>
      <div class="communities-container">
        <!-- 循环每个推荐社区 -->
        <div
          class="community-card"
          v-for="community in recommendedCommunities"
          :key="community.communityName"
        >
          <div class="community-header" @click="goToCommunity(community.communityName)">
            <h3 class="community-name">{{ community.communityName }}</h3>
            <span class="view-more">查看更多 →</span>
          </div>

          <!-- 社区帖子列表 -->
          <div class="community-posts">
            <div
              class="post-item"
              v-for="(post, idx) in communityPosts.get(community.communityName)?.slice(0, 3)"
              :key="idx"
              @click="goToCommunity(community.communityName)"
            >
              <h4 class="post-title">{{ post.postTitle }}</h4>
              <p class="post-excerpt">{{ post.postContent | truncate(100) }}</p>
              <div class="post-meta">
                <span>{{ formatTime(post.createdAt) }}</span>
                <span>👍 {{ post.likeCount }}</span>
              </div>
            </div>

            <!-- 加载状态或无数据提示 -->
            <div
              v-if="
                !communityPosts.get(community.communityName) ||
                communityPosts.get(community.communityName)!.length === 0
              "
              class="no-posts"
            >
              暂无帖子数据
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style>
/* 基础样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.home-view {
  min-width: 1200px;
  padding-top: 40px;
  color: #fff;
  background-color: #1a1a1a;
  background-image:
    radial-gradient(circle at 10% 20%, rgba(50, 50, 50, 0.1) 0%, transparent 20%),
    radial-gradient(circle at 90% 80%, rgba(50, 50, 50, 0.1) 0%, transparent 20%);
}

/* 头部横幅 */
.header-banner {
  text-align: center;
  padding: 30px 0 50px;
  position: relative;
  overflow: hidden;
}

.banner-text {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 20px;
  display: inline-block;
  color: #f0f0f0;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  font-family: serif;
}

.banner-image {
  max-width: 80%;
  height: auto;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
  transition: transform 0.3s ease;
}

.banner-image:hover {
  transform: scale(1.02);
}

/* 通用区块标题 */
.section-title {
  font-size: 1.8rem;
  margin: 0 0 30px 20px;
  color: #f5f5f5;
  position: relative;
  display: inline-block;
}

.section-title::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: -8px;
  width: 60px;
  height: 3px;
  background-color: #6c5ce7;
  border-radius: 3px;
}

/* 推荐游戏区域 */
.recommendations {
  padding: 40px 20px;
  background-color: rgba(30, 30, 30, 0.8);
  margin: 0 auto 60px;
  max-width: 1400px;
  border-radius: 16px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
}

.like-container {
  width: 100%;
  overflow: hidden;
  position: relative;
  padding: 20px 0;
}

.like-track {
  display: flex;
}

/* 游戏卡片样式 */
.game-card {
  flex: 0 0 280px; /* 卡片宽度 */
  margin: 0 15px;
  background-color: #2d2d2d;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.game-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
}

.game-visual {
  width: 100%;
  height: 180px; /* 图片区域高度 */
  overflow: hidden;
  position: relative;
}

.game-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.game-card:hover .game-image {
  transform: scale(1.08);
}

.game-info {
  padding: 18px;
  text-align: left;
}

.game-name {
  font-size: 1.1rem;
  margin-bottom: 10px;
  color: #f0f0f0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.game-description {
  font-size: 0.9rem;
  color: #bbbbbb;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 3; /* 最多显示3行 */
  -webkit-box-orient: vertical;
  overflow: hidden;
  height: 4.5em; /* 3行高度 */
}

/* 社区区域 */
.community-section {
  padding: 40px 20px;
  max-width: 1400px;
  margin: 0 auto 80px;
}

.post-card {
  background-color: #2d2d2d;
  padding: 25px;
  border-radius: 12px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

/* 原有样式保持不变 */

/* 社区内容样式 */
.community-section {
  padding: 40px 20px;
  max-width: 1400px;
  margin: 0 auto 80px;
}

.communities-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 30px;
}

.community-card {
  background-color: #2d2d2d;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.community-header {
  padding: 18px 20px;
  background-color: #383838;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
}

.community-name {
  font-size: 1.2rem;
  color: #f0f0f0;
}

.view-more {
  font-size: 0.9rem;
  color: #6c5ce7;
  transition: color 0.3s ease;
}

.community-header:hover .view-more {
  color: #8c7cf7;
}

.community-posts {
  padding: 20px;
}

.post-item {
  padding: 15px 0;
  border-bottom: 1px solid #383838;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.post-item:last-child {
  border-bottom: none;
}

.post-item:hover {
  background-color: rgba(255, 255, 255, 0.03);
}

.post-title {
  font-size: 1rem;
  color: #f0f0f0;
  margin-bottom: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.post-excerpt {
  font-size: 0.85rem;
  color: #bbbbbb;
  line-height: 1.4;
  margin-bottom: 10px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.post-meta {
  display: flex;
  justify-content: space-between;
  font-size: 0.75rem;
  color: #888;
}

.no-posts {
  text-align: center;
  padding: 20px;
  color: #888;
  font-size: 0.9rem;
}

/* 过滤器样式（用于截断文本） */
:root {
  --post-excerpt-length: 100;
}
</style>
