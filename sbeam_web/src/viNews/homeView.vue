改一下
<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted, onUnmounted, nextTick, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router' // 新增 useRoute

// 社区相关响应式数据
const recommendedCommunities = ref<any[]>([])
const communityPosts = ref<Map<string, any[]>>(new Map())

// 路由相关
const router = useRouter()
const route = useRoute() // 初始化路由对象，用于获取查询参数

// 帖子详情数据（用于详情页，当前页可保留或移至详情页组件）
const postDetail = ref<any>(null)

// 点击跳转到社区详情页（根据社区ID）
const goToCommunity = async (communityName: string) => {
  const communityId = await fetchCommunityId(communityName)
  if (communityId) {
    router.push({ path: `/community/${communityId}` })
  } else {
    alert('获取社区信息失败')
  }
}

// 跳转到帖子详情页（根据 postId）
const goToPostDetail = (postId: string) => {
  router.push({
    path: '/post-detail',
    query: { id: postId },
  })
}

// 获取社区详情（根据名称）
const fetchCommunityDetail = (communityName: string) => {
  return axios
    .get(`http://localhost:8080/community/name/${encodeURIComponent(communityName)}`)
    .then((response) => {
      return response.data.length > 0 ? response.data[0] : null
    })
    .catch((error) => {
      console.error(`获取${communityName}社区详情失败:`, error)
      return null
    })
}
const fetchCommunityId = (communityName: string) => {
  const encodedName = encodeURIComponent(communityName)
  console.log(`请求社区ID：${communityName}（编码后：${encodedName}）`)
  return axios
    .get(`http://localhost:8080/community/name/${encodedName}`)
    .then((response) => {
      console.log(`接口返回数据：`, response.data)
      const communities = response.data
      if (Array.isArray(communities) && communities.length > 0) {
        // 关键修改：从 communityId 字段获取ID（与后端返回的字段名一致）
        const id = communities[0].communityId
        console.log(`获取到${communityName}的ID：${id}`) // 此时会正确打印ID（如1）
        return id
      } else {
        console.warn(`接口返回空列表，未找到${communityName}`)
        return null
      }
    })
    .catch((error) => {
      console.error(
        `请求失败：${error.message}`,
        `状态码：${error.response?.status}`,
        `响应内容：${JSON.stringify(error.response?.data)}`,
      )
      return null
    })
}

// 获取社区帖子数据（从MongoDB查询）
const fetchCommunityPosts = (communityName: string) => {
  return axios
    .get('http://localhost:8080/post/getbycname', {
      params: { communityName },
    })
    .then((response) => {
      console.log('社区帖子数据:', response.data)
      return response.data
    })
    .catch((error) => {
      console.error(`获取${communityName}社区帖子失败:`, error)
      return []
    })
}

// 跳转到游戏详情页
const goGameDetail = (id: number) => {
  router.push({ name: 'game-detail', params: { id } })
}

// 从 localStorage 获取用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const hotItems = ref<any[]>([])
const displayItems = ref<any[]>([])

// 时间格式化工具
const formatTime = (timestamp: string) => {
  if (!timestamp) return '未知时间'
  const date = new Date(timestamp)
  return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`
}

// 获取推荐数据
const fetchRecommendations = () => {
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
      const communityDetailPromises = recommended_posts.map((item: any) =>
        fetchCommunityDetail(item.communityName),
      )
      Promise.all(communityDetailPromises).then((communities) => {
        recommendedCommunities.value = communities.filter(Boolean)
        // 为每个社区获取帖子
        recommendedCommunities.value.forEach((community) => {
          fetchCommunityPosts(community.communityName).then((posts) => {
            communityPosts.value.set(community.communityName, posts)
          })
        })
      })
    })
    .catch((error) => {
      console.error('获取推荐失败:', error)
    })
}

// 游戏轮播相关逻辑
watch(hotItems, () => {
  displayItems.value = [...hotItems.value, ...hotItems.value.slice(0, 6)]
})

const visibleCount = 4
const itemWidth = 280
const transitionTime = 800
const currentIndex = ref(0)
let timer: number | undefined
const isTransitioning = ref(true)

const startScroll = () => {
  // 防止重复创建定时器
  if (timer) clearInterval(timer)
  timer = window.setInterval(() => {
    nextTick(() => {
      currentIndex.value++
      isTransitioning.value = true
    })
  }, 3000)
}

const handleTransitionEnd = () => {
  if (currentIndex.value >= hotItems.value.length) {
    isTransitioning.value = false
    currentIndex.value = 0
  }
}

// 整合所有初始化逻辑到一个 onMounted
onMounted(() => {
  // 1. 启动轮播
  startScroll()

  // 2. 获取推荐数据
  fetchRecommendations()

  // 3. 如果是详情页逻辑，可在这里处理（当前是首页，可注释或移至详情页组件）
  // const postId = route.query.id as string
  // if (postId) {
  //   axios.get('http://localhost:8080/post/detail', { params: { postId } })
  //     .then(response => postDetail.value = response.data)
  //     .catch(error => console.error('获取帖子详情失败:', error))
  // }
})

// 组件卸载时清除定时器
onUnmounted(() => {
  if (timer) clearInterval(timer)
})

// 备用图片路径
const defaultImage = '/gameimg/kemomimi.jpg'
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement
  img.src = defaultImage
}

// 文本截断过滤器
const truncateText = (text: string, length: number) => {
  if (!text) return ''
  return text.length > length ? text.slice(0, length) + '...' : text
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
        <div
          class="community-card"
          v-for="community in recommendedCommunities"
          :key="community.communityName"
        >
          <div class="community-header" @click="goToCommunity(community.communityName)">
            <img
              v-if="community.avatarUrl"
              :src="community.avatarUrl"
              alt="Community Avatar"
              class="community-avatar"
            />
            <div class="community-info">
              <h3 class="community-name">{{ community.communityName }}</h3>
              <p class="community-desc" v-if="community.description">
                {{ truncateText(community.description, 50) }}
              </p>
            </div>
            <span class="view-more">查看更多 →</span>
          </div>

          <!-- 社区帖子列表（适配实际返回的字段） -->
          <div class="community-posts">
            <div
              class="post-item"
              v-for="(post, idx) in communityPosts.get(community.communityName)?.slice(0, 3)"
              :key="post.postId"
              @click="goToPostDetail(post.postId)"
            >
              <h4 class="post-title">{{ post.postTitle || '无标题' }}</h4>
              <!-- 展示实际的 content 字段（而非 postContent） -->
              <p class="post-excerpt">{{ truncateText(post.content, 100) }}</p>
              <div class="post-meta">
                <span>{{ formatTime(post.createdAt) }}</span>
                <span>👍 {{ post.likeCount || 0 }}</span>
              </div>
            </div>

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
/* 样式保持不变 */
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
  flex: 0 0 280px;
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
  height: 180px;
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
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  height: 4.5em;
}

/* 社区区域 */
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
  align-items: center;
  gap: 15px;
  cursor: pointer;
}

.community-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #6c5ce7;
}

.community-info {
  flex: 1;
}

.community-name {
  font-size: 1.2rem;
  color: #f0f0f0;
  margin-bottom: 5px;
}

.community-desc {
  font-size: 0.85rem;
  color: #bbbbbb;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.view-more {
  font-size: 0.9rem;
  color: #6c5ce7;
  transition: color 0.3s ease;
  white-space: nowrap;
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
</style>
