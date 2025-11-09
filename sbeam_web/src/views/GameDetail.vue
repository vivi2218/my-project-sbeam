<template>
  <!-- loading / error states -->
  <div v-if="loading" class="game-loading">
    <div class="loading-card">
      <div class="loading-spinner"></div>
      <p class="loading-text">加载游戏详情中...</p>
    </div>
  </div>

  <div v-else-if="error" class="game-error">
    <div class="error-card">
      <div class="error-icon">⚠️</div>
      <p class="error-text">{{ error }}</p>
      <div class="error-actions">
        <button class="btn btn-retry" @click="fetchGameDetails">重试加载</button>
      </div>
    </div>
  </div>

  <!-- 游戏详情主体 -->
  <div v-else class="game-detail-container">
    <!-- 顶部横幅 -->
    <div class="game-header-banner">
      <div class="banner-overlay"></div>
      <div class="banner-content">
        <h1 class="game-title">{{ gameDetail.gameName }}</h1>
        <div class="game-meta-tags">
          <span class="tag" v-if="gameDetail.gameProfile?.gameTagName">{{
            gameDetail.gameProfile.gameTagName
          }}</span>
          <span class="tag" v-if="gameDetail.gameProfile?.series"
            >系列：{{ gameDetail.gameProfile.series }}</span
          >
          <span class="tag">{{ gameDetail.gameProfile?.gameDeveloper }}</span>
        </div>
      </div>
    </div>

    <!-- 游戏基本信息 -->
    <div class="game-info-wrapper">
      <div class="game-gallery">
        <img
          :src="`/gameimg/${gameDetail.gameId}.jpg`"
          alt="游戏封面"
          class="main-cover"
          @error="(e) => (e.target.src = '/gameimg/default.jpg')"
        />

        <!-- 缩略图预览 -->
        <div class="thumbnail-list" v-if="gameDetail.gameImages && gameDetail.gameImages.length">
          <img
            v-for="(image, index) in gameDetail.gameImages"
            :key="index"
            :src="image"
            :alt="`截图${index + 1}`"
            class="thumbnail-item"
            @click="activeScreenshot = image"
          />
        </div>
      </div>

      <div class="game-purchase-panel">
        <div class="price-card">
          <div class="price-display">
            <span class="current-price">{{ gameDetail.gameOriginalPrice }} USD</span>
            <span
              class="original-price"
              v-if="gameDetail.priceHistory && gameDetail.priceHistory.length"
            >
              {{ gameDetail.priceHistory[0].price }} USD
            </span>
            <span class="release-date">发行日期：{{ formattedReleaseDate }}</span>
          </div>

          <div class="action-buttons">
            <button class="btn btn-buy">立即购买</button>
            <button class="btn btn-cart" :class="{ added: isAddedToCart }" @click="addToCart">
              <i class="icon-cart"></i>
              {{ isAddedToCart ? '已加入购物车' : '加入购物车' }}
            </button>
            <button
              class="btn btn-wishlist"
              :class="{ followed: gameDetail.userFollowed }"
              @click="toggleFollow"
            >
              <i class="icon-heart"></i>
              {{ gameDetail.userFollowed ? '已关注' : '愿望单' }}
            </button>
          </div>
        </div>

        <div class="game-desc">
          <h3 class="desc-title">游戏简介</h3>
          <p class="desc-content">
            {{ gameDetail.gameProfile?.gameDescription || '暂无游戏简介' }}
          </p>
        </div>
      </div>
    </div>

    <!-- 游戏截图预览 -->
    <div class="screenshot-preview" v-if="gameDetail.gameImages && gameDetail.gameImages.length">
      <h2 class="section-title"><i class="icon-screenshot"></i> 游戏截图</h2>
      <div class="screenshot-container">
        <img :src="activeScreenshot" :alt="gameDetail.gameName" class="active-screenshot" />
      </div>
    </div>

    <!-- 内容标签页 -->
    <div class="game-tabs">
      <div class="tab-buttons">
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'bundles' }"
          @click="activeTab = 'bundles'"
        >
          捆绑包
        </button>
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'price' }"
          @click="activeTab = 'price'"
        >
          价格历史
        </button>
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'achievements' }"
          @click="activeTab = 'achievements'"
        >
          成就
        </button>
        <button
          class="tab-btn"
          :class="{ active: activeTab === 'details' }"
          @click="activeTab = 'details'"
        >
          游戏详情
        </button>
      </div>

      <div class="tab-content">
        <!-- 捆绑包 -->
        <div v-if="activeTab === 'bundles'" class="tab-pane">
          <div class="bundle-list">
            <div
              class="bundle-card"
              v-for="bundle in gameDetail.gameBundles"
              :key="bundle.bundleName"
            >
              <h3 class="bundle-name">{{ bundle.bundleName }}</h3>
              <p class="bundle-discount">{{ bundle.discountPolicy || '无特殊折扣政策' }}</p>
              <button class="btn btn-bundle">查看捆绑包</button>
            </div>
            <div
              class="empty-state"
              v-if="!gameDetail.gameBundles || gameDetail.gameBundles.length === 0"
            >
              暂无可用捆绑包
            </div>
          </div>
        </div>

        <!-- 价格历史 -->
        <div v-if="activeTab === 'price'" class="tab-pane">
          <div class="price-history-list">
            <div
              class="price-record"
              v-for="(history, idx) in gameDetail.priceHistory || []"
              :key="idx"
            >
              <span class="price-date">{{ formatDate(history.priceDate) }}</span>
              <span class="price-value">{{ history.price }} USD</span>
            </div>
            <div
              class="empty-state"
              v-if="!gameDetail.priceHistory || gameDetail.priceHistory.length === 0"
            >
              暂无价格历史记录
            </div>
          </div>
        </div>

        <!-- 成就 -->
        <div v-if="activeTab === 'achievements'" class="tab-pane">
          <div class="achievements-grid">
            <div
              class="achievement-card"
              v-for="achievement in gameDetail.gameAchievements"
              :key="achievement.achievementName"
            >
              <div class="achievement-icon">🏆</div>
              <h3 class="achievement-name">{{ achievement.achievementName }}</h3>
              <p class="achievement-desc">{{ achievement.achievementDescription || '无描述' }}</p>
            </div>
            <div
              class="empty-state"
              v-if="!gameDetail.gameAchievements || gameDetail.gameAchievements.length === 0"
            >
              暂无成就信息
            </div>
          </div>
        </div>

        <!-- 游戏详情 -->
        <div v-if="activeTab === 'details'" class="tab-pane">
          <div class="game-details-table">
            <div class="detail-row">
              <span class="detail-label">开发商</span>
              <span class="detail-value">{{
                gameDetail.gameProfile?.gameDeveloper || '未知'
              }}</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">游戏标签</span>
              <span class="detail-value">{{ gameDetail.gameProfile?.gameTagName || '无' }}</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">系列作品</span>
              <span class="detail-value">{{ gameDetail.gameProfile?.series || '无' }}</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">配置要求</span>
              <span class="detail-value">{{
                gameDetail.gameProfile?.gameConfig || '暂无配置信息'
              }}</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">发行日期</span>
              <span class="detail-value">{{ formattedReleaseDate || '未知' }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const isAddedToCart = ref(false)
const activeTab = ref('bundles') // 默认显示捆绑包标签页
const activeScreenshot = ref('')

// 接口类型定义
interface GameDetail {
  gameId?: number | string
  releaseDate?: number[]
  mainImageUrl?: string
  gameName?: string
  gameOriginalPrice?: number | string
  gameImages?: string[]
  gameBundles?: Array<{ bundleName: string; discountPolicy?: string }>
  priceHistory?: Array<{ priceDate: number[]; price: number }>
  gameAchievements?: Array<{ achievementName: string; achievementDescription?: string }>
  gameProfile?: {
    gameDeveloper?: string
    gameTagName?: string
    gameConfig?: string
    series?: string
    gameDescription?: string
  }
  userFollowed?: boolean
}

const gameDetail = ref<GameDetail>({})
const loading = ref<boolean>(true)
const error = ref<string>('')

// 格式化发行日期
const formattedReleaseDate = computed(() => {
  const d = gameDetail.value.releaseDate
  return d ? `${d[0]}-${d[1].toString().padStart(2, '0')}-${d[2].toString().padStart(2, '0')}` : ''
})

// 格式化日期
function formatDate(dateArray: number[]) {
  return `${dateArray[0]}-${dateArray[1].toString().padStart(2, '0')}-${dateArray[2].toString().padStart(2, '0')}`
}

// 监听游戏截图变化，设置默认活跃截图
watch(
  () => gameDetail.value.gameImages,
  (newImages) => {
    if (newImages && newImages.length > 0) {
      activeScreenshot.value = newImages[0]
    }
  },
)

// 加入购物车
async function addToCart() {
  if (isAddedToCart.value) return

  try {
    const gameId = route.params.id
    const gamePrice = gameDetail.value.gameOriginalPrice

    const token = localStorage.getItem('sbeam_token')
    if (!token) {
      alert('请先登录后再操作')
      return
    }

    const res = await axios.post('http://localhost:8080/cart/add', null, {
      headers: { Authorization: token },
      params: { gameId, gamePrice },
    })

    if (res.data.code === 200) {
      isAddedToCart.value = true
      alert('已成功加入购物车！')
    } else {
      alert(res.data.msg || '加入购物车失败，请稍后重试')
    }
  } catch (err) {
    console.error(err)
    alert('加入购物车失败，请稍后重试')
  }
}

// 关注/取消关注
async function toggleFollow() {
  try {
    const gameId = route.params.id
    const token = localStorage.getItem('sbeam_token')

    if (!token) {
      alert('请先登录后再操作')
      return
    }

    // 这里需要根据实际接口调整
    const res = await axios.post(
      `http://localhost:8080/game/${gameDetail.value.userFollowed ? 'unfollow' : 'follow'}`,
      null,
      {
        headers: { Authorization: token },
        params: { gameId },
      },
    )

    if (res.data.code === 200) {
      gameDetail.value.userFollowed = !gameDetail.value.userFollowed
    } else {
      alert(res.data.msg || '操作失败，请稍后重试')
    }
  } catch (err) {
    console.error(err)
    alert('操作失败，请稍后重试')
  }
}

// 获取游戏详情
async function fetchGameDetails() {
  loading.value = true
  error.value = ''
  try {
    const id = route.params.id
    const res = await axios.get(`http://localhost:8080/game/details/${id}`)
    const payload = res.data?.data ?? res.data
    if (!payload) throw new Error('后端返回空数据')
    gameDetail.value = payload
  } catch (err: unknown) {
    console.error('获取游戏详情失败:', err)
    const maybeErr = err as { message?: string } | undefined
    const msg = maybeErr?.message ? maybeErr.message : String(err)
    error.value = msg || '获取游戏详情失败，请稍后重试'
  } finally {
    loading.value = false
  }
}

// 页面加载时获取游戏详情
onMounted(() => {
  fetchGameDetails()
})
</script>

<style scoped>
/* 全局变量 */
:root {
  --primary: #ff4d6d;
  --primary-dark: #c73a54;
  --secondary: #7b2cbf;
  --success: #38b000;
  --success-dark: #2a8000;
  --warning: #ffb703;
  --dark: #0f172a;
  --dark-light: #1e293b;
  --gray: #64748b;
  --light: #f8fafc;
  --border-radius: 8px;
  --shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  --transition: all 0.3s ease;
}

/* 基础样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Roboto', sans-serif;
}

body {
  background-color: var(--dark);
  color: var(--light);
  min-height: 100vh;
}

/* 加载状态 */
.game-loading {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 80vh;
  padding: 20px;
}

.loading-card {
  background-color: var(--dark-light);
  padding: 40px 60px;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow);
  text-align: center;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.loading-spinner {
  width: 40px;
  height: 40px;
  margin: 0 auto 20px;
  border: 4px solid rgba(255, 255, 255, 0.1);
  border-top: 4px solid var(--primary);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.loading-text {
  color: var(--light);
  font-size: 18px;
  letter-spacing: 1px;
}

/* 错误状态 */
.game-error {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
  padding: 20px;
}

.error-card {
  background-color: #2a1518;
  padding: 40px;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow);
  text-align: center;
  max-width: 500px;
  width: 100%;
  border: 1px solid rgba(255, 77, 109, 0.2);
}

.error-icon {
  font-size: 48px;
  margin-bottom: 20px;
}

.error-text {
  color: #ffdede;
  font-size: 16px;
  margin-bottom: 25px;
  line-height: 1.6;
}

/* 按钮样式 */
.btn {
  padding: 12px 24px;
  border-radius: var(--border-radius);
  border: none;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: var(--transition);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.btn-retry {
  background-color: var(--primary);
  color: white;
}

.btn-retry:hover {
  background-color: var(--primary-dark);
}

.btn-buy {
  background: linear-gradient(135deg, var(--primary), var(--primary-dark));
  color: white;
  flex: 1;
}

.btn-buy:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(255, 77, 109, 0.3);
}

.btn-cart {
  background-color: var(--success);
  color: white;
}

.btn-cart.added {
  background-color: var(--gray);
  cursor: not-allowed;
}

.btn-cart:not(.added):hover {
  background-color: var(--success-dark);
}

.btn-wishlist {
  background-color: transparent;
  color: var(--light);
  border: 1px solid var(--gray);
}

.btn-wishlist.followed {
  color: var(--primary);
  border-color: var(--primary);
}

.btn-wishlist:hover:not(.followed) {
  border-color: var(--light);
}

.btn-bundle {
  background-color: var(--secondary);
  color: white;
  margin-top: 15px;
  padding: 8px 16px;
  font-size: 14px;
}

.btn-bundle:hover {
  background-color: #6a24aa;
}

/* 游戏详情容器 */
.game-detail-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 顶部横幅 */
.game-header-banner {
  position: relative;
  height: 300px;
  margin: 40px 0 60px;
  border-radius: var(--border-radius);
  overflow: hidden;
  background: linear-gradient(135deg, var(--secondary), var(--dark));
}

.banner-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    to right,
    rgba(15, 23, 42, 0.9),
    rgba(15, 23, 42, 0.5) 70%,
    rgba(15, 23, 42, 0.8)
  );
}

.banner-content {
  position: relative;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 60px;
  z-index: 1;
}

.game-title {
  font-size: 42px;
  margin-bottom: 20px;
  color: var(--light);
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

.game-meta-tags {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.tag {
  background-color: rgba(255, 255, 255, 0.1);
  color: var(--light);
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 14px;
  backdrop-filter: blur(4px);
}

/* 游戏信息区域 */
.game-info-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  margin-bottom: 60px;
}

/* 游戏画廊 */
.game-gallery {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.main-cover {
  width: 100%;
  height: 500px;
  object-fit: cover;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow);
  border: 1px solid rgba(255, 255, 255, 0.08);
  transition: var(--transition);
}

.main-cover:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
}

.thumbnail-list {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding-bottom: 10px;
}

.thumbnail-item {
  width: 100px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  cursor: pointer;
  border: 2px solid transparent;
  transition: var(--transition);
}

.thumbnail-item:hover,
.thumbnail-item.active {
  border-color: var(--primary);
  transform: scale(1.05);
}

/* 购买面板 */
.game-purchase-panel {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.price-card {
  background-color: var(--dark-light);
  border-radius: var(--border-radius);
  padding: 30px;
  box-shadow: var(--shadow);
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.price-display {
  margin-bottom: 30px;
}

.current-price {
  font-size: 36px;
  font-weight: 700;
  color: var(--primary);
  margin-right: 15px;
}

.original-price {
  font-size: 20px;
  color: var(--gray);
  text-decoration: line-through;
}

.release-date {
  display: block;
  margin-top: 10px;
  color: var(--gray);
  font-size: 14px;
}

.action-buttons {
  display: flex;
  gap: 15px;
}

/* 游戏描述 */
.game-desc {
  background-color: var(--dark-light);
  border-radius: var(--border-radius);
  padding: 30px;
  box-shadow: var(--shadow);
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.desc-title {
  font-size: 20px;
  margin-bottom: 15px;
  color: var(--light);
}

.desc-content {
  color: #e2e8f0;
  line-height: 1.8;
  font-size: 16px;
}

/* 截图预览 */
.screenshot-preview {
  margin-bottom: 60px;
}

.section-title {
  font-size: 24px;
  margin-bottom: 20px;
  color: var(--light);
  display: flex;
  align-items: center;
  gap: 10px;
}

.icon-screenshot::before {
  content: '🖼️';
}

.screenshot-container {
  width: 100%;
  border-radius: var(--border-radius);
  overflow: hidden;
  box-shadow: var(--shadow);
}

.active-screenshot {
  width: 100%;
  height: auto;
  object-fit: cover;
  transition: var(--transition);
}

/* 标签页样式 */
.game-tabs {
  margin-bottom: 80px;
  background-color: var(--dark-light);
  border-radius: var(--border-radius);
  overflow: hidden;
  box-shadow: var(--shadow);
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.tab-buttons {
  display: flex;
  background-color: rgba(0, 0, 0, 0.1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.tab-btn {
  padding: 18px 30px;
  background: none;
  border: none;
  color: var(--gray);
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: var(--transition);
  flex: 1;
}

.tab-btn:hover:not(.active) {
  color: var(--light);
  background-color: rgba(255, 255, 255, 0.05);
}

.tab-btn.active {
  color: var(--primary);
  border-bottom: 3px solid var(--primary);
}

.tab-content {
  padding: 0;
}

.tab-pane {
  padding: 30px;
  animation: fadeIn 0.3s ease;
}

/* 捆绑包列表 */
.bundle-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.bundle-card {
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: var(--border-radius);
  padding: 20px;
  transition: var(--transition);
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.bundle-card:hover {
  transform: translateY(-5px);
  background-color: rgba(0, 0, 0, 0.2);
}

.bundle-name {
  font-size: 18px;
  margin-bottom: 10px;
  color: var(--light);
}

.bundle-discount {
  color: #e2e8f0;
  line-height: 1.6;
  margin-bottom: 15px;
}

/* 价格历史 */
.price-history-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.price-record {
  display: flex;
  justify-content: space-between;
  padding: 15px;
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: var(--border-radius);
  border: 1px solid rgba(255, 255, 255, 0.05);
  transition: var(--transition);
}

.price-record:hover {
  background-color: rgba(0, 0, 0, 0.2);
}

.price-date {
  color: var(--gray);
}

.price-value {
  font-weight: 600;
  color: var(--light);
}

/* 成就列表 */
.achievements-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.achievement-card {
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: var(--border-radius);
  padding: 20px;
  transition: var(--transition);
  border: 1px solid rgba(255, 255, 255, 0.05);
  text-align: center;
}

.achievement-card:hover {
  transform: translateY(-5px);
  background-color: rgba(0, 0, 0, 0.2);
}

.achievement-icon {
  font-size: 40px;
  margin-bottom: 15px;
}

.achievement-name {
  font-size: 18px;
  margin-bottom: 10px;
  color: var(--light);
}

.achievement-desc {
  color: #e2e8f0;
  line-height: 1.6;
}

/* 游戏详情表格 */
.game-details-table {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.detail-row {
  display: flex;
  padding: 15px;
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: var(--border-radius);
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.detail-label {
  flex: 0 0 150px;
  font-weight: 600;
  color: var(--gray);
}

.detail-value {
  flex: 1;
  color: var(--light);
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: var(--gray);
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: var(--border-radius);
  border: 1px dashed rgba(255, 255, 255, 0.1);
}

/* 动画 */
@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 响应式调整 */
@media (max-width: 1024px) {
  .game-info-wrapper {
    grid-template-columns: 1fr;
  }

  .game-header-banner {
    height: 250px;
  }

  .game-title {
    font-size: 32px;
  }
}

@media (max-width: 768px) {
  .action-buttons {
    flex-direction: column;
  }

  .game-header-banner {
    height: 200px;
    margin: 20px 0 40px;
  }

  .banner-content {
    padding: 0 30px;
  }

  .game-title {
    font-size: 24px;
  }

  .tab-btn {
    padding: 14px 10px;
    font-size: 14px;
  }

  .main-cover {
    height: 350px;
  }
}

/* 图标样式 */
.icon-cart::before {
  content: '🛒';
}

.icon-heart::before {
  content: '♥';
}
</style>
