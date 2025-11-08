<script setup lang="ts">
import { ref, onMounted, watch, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const keyword = ref((route.query.keyword as string) || '')
const results = ref<Array<any>>([])
const loading = ref(false)

// 分离游戏和帖子结果
const games = computed(() => {
  return results.value.filter((item) => item.type === 'game')
})

const posts = computed(() => {
  return results.value.filter((item) => item.type === 'community')
})

// 搜索接口
const fetchResults = async () => {
  if (!keyword.value) return
  loading.value = true
  try {
    const res = await axios.get(`http://localhost:8080/search/search`, {
      params: { keyword: keyword.value },
    })
    results.value = res.data.map((item: any) => {
      if (item.type === 'game' && item.gameId) {
        return {
          ...item,
          imageUrl: `/gameimg/${item.gameId}.jpg`,
        }
      }
      return { ...item, imageUrl: item.imageUrl || null }
    })
  } catch (err) {
    console.error('搜索失败', err)
    results.value = []
  } finally {
    loading.value = false
  }
}

onMounted(fetchResults)
watch(
  () => route.query.keyword,
  (newKeyword) => {
    keyword.value = newKeyword as string
    fetchResults()
  },
)

const goToDetail = (item: any) => {
  if (item.type === 'game') {
    router.push({ name: 'game-detail', params: { id: item.gameId } })
  } else if (item.type === 'community') {
    router.push({ name: 'community-detail', params: { id: item.communityId } })
  }
}
</script>

<template>
  <div class="search-page">
    <!-- 搜索头部 -->
    <div class="search-header">
      <div class="main-container">
        <div class="header-content">
          <h1>搜索结果</h1>
          <div class="search-info">
            <span>关键词:</span>
            <span class="keyword">{{ keyword }}</span>
            <span v-if="!loading" class="count"> (共 {{ results.length }} 个结果) </span>
          </div>
        </div>
      </div>
    </div>

    <!-- 主内容区 -->
    <div class="main-container">
      <!-- 加载状态 -->
      <div class="loading-state" v-if="loading">
        <div class="loader"></div>
        <p>搜索中...</p>
      </div>

      <div v-else>
        <!-- 无结果状态 -->
        <div class="no-results" v-if="results.length === 0">
          <div class="no-results-icon">🔍</div>
          <h3>未找到相关内容</h3>
          <p>尝试其他关键词</p>
        </div>

        <!-- 游戏结果容器 -->
        <div class="category-container" v-if="games.length > 0">
          <h2 class="category-title">🎮 游戏结果 ({{ games.length }})</h2>
          <div class="results-grid">
            <div
              class="result-card"
              v-for="item in games"
              :key="'game-' + item.gameId"
              @click="goToDetail(item)"
            >
              <div class="card-image">
                <img
                  v-if="item.imageUrl"
                  :src="item.imageUrl"
                  :alt="item.gameName"
                  class="card-img"
                  loading="lazy"
                />
                <div v-else class="no-image">无图</div>
              </div>

              <div class="card-info">
                <h3 class="card-title">{{ item.gameName }}</h3>
                <p class="card-price" v-if="item.gameOriginalPrice">
                  ¥{{ item.gameOriginalPrice }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- 帖子结果容器 - 显示communityName和communityDescription -->
        <div class="category-container" v-if="posts.length > 0">
          <h2 class="category-title">📝 社区搜索结果 ({{ posts.length }})</h2>
          <div class="posts-list">
            <div
              class="post-card"
              v-for="item in posts"
              :key="'community-' + item.communityId"
              @click="goToDetail(item)"
            >
              <!-- 帖子图片（如果有） -->
              <div class="post-image" v-if="item.imageUrl">
                <img
                  :src="item.imageUrl"
                  :alt="item.communityName"
                  class="post-img"
                  loading="lazy"
                />
              </div>

              <!-- 帖子信息区域 - 显示名称和描述 -->
              <div class="post-info">
                <h3 class="post-title">{{ item.communityName }}</h3>
                <p class="post-description">{{ item.communityDescription }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* 基础样式 - 暗色系主题 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', Roboto, sans-serif;
}

.search-page {
  width: 1400px;
  background-color: #121212;
  color: #e0e0e0;
  min-height: 100vh;
  padding-bottom: 2rem;
}

/* 宽容器设置 */
.main-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  width: 100%;
}

/* 搜索头部 */
.search-header {
  background-color: #1e1e1e;
  color: #ffffff;
  padding: 0.8rem 0;
  margin-bottom: 1.5rem;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

.header-content {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}

.search-header h1 {
  font-size: 1.4rem;
  font-weight: 600;
}

.search-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.95rem;
  color: #bbbbbb;
}

.keyword {
  color: #4ad2ff;
  font-weight: 500;
  padding: 0 4px;
  border-radius: 2px;
  background: rgba(255, 255, 255, 0.1);
}

.count {
  color: #999999;
  font-size: 0.9rem;
}

/* 加载状态 */
.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 3rem 0;
  color: #999999;
}

.loader {
  width: 36px;
  height: 36px;
  border: 3px solid #333333;
  border-bottom-color: #4ad2ff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 0.6rem;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

/* 无结果状态 */
.no-results {
  text-align: center;
  padding: 3rem 0;
  color: #999999;
}

.no-results-icon {
  font-size: 2.5rem;
  margin-bottom: 0.8rem;
  opacity: 0.7;
}

.no-results h3 {
  font-size: 1.2rem;
  margin-bottom: 0.3rem;
  color: #e0e0e0;
}

/* 分类容器 */
.category-container {
  margin-bottom: 2.5rem;
  width: 100%;
}

.category-title {
  font-size: 1.2rem;
  margin-bottom: 1rem;
  color: #ffffff;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid #333333;
}

/* 游戏结果网格 */
.results-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 18px;
  width: 100%;
}

.result-card,
.post-card {
  background: #1e1e1e;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.4);
  transition: all 0.2s ease;
  cursor: pointer;
}

.result-card:hover,
.post-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.5);
}

.result-card {
  height: 100%;
}

/* 游戏卡片图片 */
.card-image {
  position: relative;
  height: 160px;
  overflow: hidden;
  background: #2d2d2d;
}

.card-img,
.post-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.result-card:hover .card-img,
.post-card:hover .post-img {
  transform: scale(1.04);
}

.no-image {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666666;
  font-size: 0.9rem;
  background: #2d2d2d;
}

/* 游戏卡片信息 */
.card-info {
  padding: 12px;
}

.card-title {
  font-size: 1rem;
  color: #ffffff;
  margin: 0 0 5px 0;
  font-weight: 500;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-price {
  color: #ff6b6b;
  font-weight: 600;
  font-size: 0.95rem;
  margin: 0;
}

/* 帖子结果列表 - 显示名称和描述 */
.posts-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.post-card {
  display: flex;
  align-items: center;
  padding: 15px;
}

/* 帖子图片区域 */
.post-image {
  flex: 0 0 80px;
  height: 80px;
  overflow: hidden;
  background: #2d2d2d;
  border-radius: 4px;
  margin-right: 15px;
}

/* 帖子信息区域 */
.post-info {
  flex: 1;
}

.post-title {
  font-size: 1.1rem;
  color: #ffffff;
  margin: 0 0 5px 0;
  font-weight: 500;
}

/* 帖子描述样式 */
.post-description {
  font-size: 0.9rem;
  color: #bbbbbb;
  margin: 0;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* 响应式调整 */
@media (max-width: 1200px) {
  .main-container {
    max-width: 1100px;
  }
}

@media (max-width: 992px) {
  .results-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 576px) {
  .main-container {
    max-width: 100%;
    padding: 0 10px;
  }
  .results-grid {
    grid-template-columns: 1fr;
  }

  .post-card {
    flex-direction: column;
    align-items: flex-start;
  }

  .post-image {
    width: 100%;
    flex: none;
    height: 120px;
    margin-right: 0;
    margin-bottom: 10px;
  }
}
</style>
