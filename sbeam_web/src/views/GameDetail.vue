<template>
  <!-- loading / error states -->
  <div v-if="loading" class="game-loading">
    <div class="loading-card">
      <p class="loading-text">加载中...</p>
    </div>
  </div>

  <div v-else-if="error" class="game-error">
    <div class="error-card">
      <p class="error-text">{{ error }}</p>
      <div class="error-actions">
        <button class="cart-btn" @click="fetchGameDetails">重试</button>
      </div>
    </div>
  </div>

  <!-- only render after gameDetail and nested gameProfile are available to avoid undefined access -->
  <div v-else class="game-detail">
    <!-- 游戏基本信息 -->
    <div class="game-info">
      <div class="left">
        <img :src="gameDetail.mainImageUrl" alt="游戏主图" class="main-image" />
      </div>
      <div class="middle-meta">
        <h1>{{ gameDetail.gameName }}</h1>
        <div class="meta-row">
          <span class="tag">{{ gameDetail.gameProfile?.gameTagName }}</span>
          <span class="tag" v-if="gameDetail.gameProfile?.series"
            >系列：{{ gameDetail.gameProfile.series }}</span
          >
        </div>
        <p class="muted">开发商：{{ gameDetail.gameProfile?.gameDeveloper }}</p>
        <p class="muted">发行日期：{{ formattedReleaseDate }}</p>
        <p class="desc">{{ gameDetail.gameProfile?.gameDescription }}</p>

        <div class="price-row">
          <div class="price">{{ gameDetail.gameOriginalPrice }} USD</div>
          <div
            class="original-price"
            v-if="gameDetail.priceHistory && gameDetail.priceHistory.length"
          >
            历史价：{{ gameDetail.priceHistory[0].price }} USD
          </div>
        </div>

        <div class="buy-actions">
          <button class="buy-btn">立即购买</button>
          <button class="cart-btn" @click="addToCart">加入购物车</button>
          <button class="wishlist-btn" @click="toggleFollow">
            {{ gameDetail.userFollowed ? '已关注' : '愿望单' }}
          </button>
        </div>
      </div>
    </div>

    <!-- 游戏图片展示 -->
    <div class="game-images">
      <h2>游戏截图</h2>
      <div class="image-list">
        <img
          v-for="(image, index) in gameDetail.gameImages || []"
          :key="index"
          :src="image"
          :alt="image"
          class="image-item"
        />
      </div>
    </div>

    <!-- 捆绑包展示 -->
    <div class="game-bundles">
      <h2>捆绑包</h2>
      <div v-for="bundle in gameDetail.gameBundles" :key="bundle.bundleName">
        <p>
          <strong>{{ bundle.bundleName }}</strong>
        </p>
        <p>{{ bundle.discountPolicy }}</p>
      </div>
    </div>

    <!-- 价格历史 -->
    <div class="price-history">
      <h2>价格历史</h2>
      <div v-for="(history, idx) in gameDetail.priceHistory || []" :key="idx">
        <p>日期：{{ formatDate(history.priceDate) }} - 价格：{{ history.price }} USD</p>
      </div>
    </div>

    <!-- 游戏成就 -->
    <div class="game-achievements">
      <h2>游戏成就</h2>
      <div v-for="achievement in gameDetail.gameAchievements" :key="achievement.achievementName">
        <p>
          <strong>{{ achievement.achievementName }}</strong
          >: {{ achievement.achievementDescription }}
        </p>
      </div>
    </div>

    <!-- 游戏详情 -->
    <div class="game-profile">
      <h2>游戏详情</h2>
      <p><strong>开发商：</strong>{{ gameDetail.gameProfile.gameDeveloper }}</p>
      <p><strong>标签：</strong>{{ gameDetail.gameProfile.gameTagName }}</p>
      <p><strong>游戏配置：</strong>{{ gameDetail.gameProfile.gameConfig }}</p>
      <p><strong>系列：</strong>{{ gameDetail.gameProfile.series }}</p>
    </div>

    <!-- 用户关注状态 -->
    <div class="user-follow">
      <button @click="toggleFollow">
        {{ gameDetail.userFollowed ? '取消关注' : '关注游戏' }}
      </button>
    </div>
    <!-- 加入购物车按钮 -->
    <div class="add-to-cart">
      <button @click="addToCart">加入购物车</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const route = useRoute()

interface GameDetail {
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

const formattedReleaseDate = computed(() => {
  const d = gameDetail.value.releaseDate
  return d ? `${d[0]}-${d[1]}-${d[2]}` : ''
})

function formatDate(dateArray) {
  return `${dateArray[0]}-${dateArray[1]}-${dateArray[2]}`
}

function toggleFollow() {
  if (!gameDetail.value) return
  gameDetail.value.userFollowed = !gameDetail.value.userFollowed
}
function addToCart() {
  alert('已将游戏加入购物车！')
}

async function fetchGameDetails() {
  loading.value = true
  error.value = ''
  try {
    const id = route.params.id
    const res = await axios.get(`http://localhost:8080/game/details/${id}`)
    // 支持两种后端结构：{ data: { data: {...} } } 或 { data: {...} }
    const payload = res.data?.data ?? res.data
    if (!payload) throw new Error('后端返回空数据')
    gameDetail.value = payload
  } catch (err: unknown) {
    console.error('获取游戏详情失败:', err)
    const maybeErr = err as { message?: string } | undefined
    const msg = maybeErr && maybeErr.message ? maybeErr.message : String(err)
    error.value = msg || '获取游戏详情失败，请稍后重试'
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  const gameId = route.params.id || 1

  fetchGameDetails(gameId)
})
</script>

<style scoped>
/* ----------------------------
   Steam-like Game Detail CSS
   - Dark theme
   - Left cover + right meta column
   - Horizontal screenshot strip
   - Prominent buy area
   ---------------------------- */

/* :root {
  --gd-bg: #0b1418;
  --card: rgba(255,255,255,0.02);
  --muted: rgba(220,230,240,0.7);
  --text: #dbe9f7;
  --accent: #66c0ff;
  --accent-2: #2ea3e6;
  --radius: 10px;
} */

.game-detail {
  max-width: 1240px;
  margin: 20px auto;
  padding: 18px;
  color: var(--text);
}

/* header */
.game-info {
  margin: 0 auto; /* 水平居中 */
  padding: 0%;
  display: grid;
  width: 1200px;
  grid-template-columns: 380px 1fr;
  gap: 20px;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.01), rgba(0, 0, 0, 0.03));
  padding: 18px;
  border-radius: var(--radius);
  box-shadow: 0 10px 30px rgba(3, 10, 18, 0.6);
}

.main-image {
  width: 100%;
  height: 480px;
  object-fit: cover;
  border-radius: 6px;
  background: #05121a;
  box-shadow: 0 8px 24px rgba(2, 8, 15, 0.6);
}

.game-info h1 {
  font-size: 30px;
  margin: 0 0 6px 0;
  color: #eaf6ff;
}
.game-info p {
  margin: 6px 0;
  color: var(--muted);
}

.price-row {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 10px;
}
.price {
  font-size: 28px;
  color: var(--accent);
  font-weight: 800;
}
.original-price {
  font-size: 14px;
  color: rgba(214, 27, 27, 0.45);
  text-decoration: line-through;
}

.buy-actions {
  margin-top: 14px;
  display: flex;
  gap: 12px;
  align-items: center;
}
.buy-btn {
  background: linear-gradient(180deg, var(--accent), var(--accent-2));
  color: #022433;
  border: none;
  padding: 12px 18px;
  border-radius: 6px;
  font-weight: 800;
  cursor: pointer;
}
.cart-btn {
  background: #1e2b33;
  color: var(--text);
  border: 1px solid rgba(255, 255, 255, 0.04);
  padding: 10px 14px;
  border-radius: 6px;
}
.wishlist-btn {
  background: transparent;
  color: var(--text);
  border: 1px solid rgba(255, 255, 255, 0.04);
  padding: 10px 14px;
  border-radius: 6px;
}

/* right column details layout */
.middle-meta {
  display: flex;
  flex-direction: column;
  width: 400px;
  gap: 12px;
}

.right-meta {
  display: flex;
  flex-direction: column;
  width: 400px;
  gap: 12px;
}
.meta-row {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}
.tag {
  background: rgba(255, 255, 255, 0.03);
  color: #bfe9ff;
  padding: 6px 10px;
  border-radius: 4px;
  font-size: 13px;
}

/* screenshot strip */
.game-images {
  margin-top: 18px;
}
.image-list {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding-bottom: 8px;
}
.image-item {
  width: 360px;
  height: 200px;
  object-fit: cover;
  border-radius: 6px;
  flex: 0 0 auto;
  transition: transform 0.16s ease;
}
.image-item:hover {
  transform: translateY(-6px);
}

/* cards (bundles, history, achievements, profile) */
.card {
  background: var(--card);
  padding: 16px;
  border-radius: 6px;
  margin-top: 18px;
}
.card h2 {
  margin: 0 0 10px 0;
  color: #eaf6ff;
}
.card p {
  margin: 6px 0;
  color: var(--muted);
}

/* specific card elements already use .card-like styles via .card class or individual rules above */

.achievement-badge {
  display: inline-block;
  background: rgba(255, 255, 255, 0.03);
  padding: 8px 10px;
  border-radius: 4px;
  margin: 6px 8px 6px 0;
}

.user-follow {
  margin-top: 12px;
}
.add-to-cart {
  margin-top: 12px;
}

/* loading */
.game-loading {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
}
.loading-card {
  width: 92%;
  max-width: 1000px;
  background: linear-gradient(180deg, #07121a, #06121a);
  padding: 28px;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.03);
}
.loading-text {
  color: #8fcff6;
  font-size: 18px;
}

/* error state */
.game-error {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 40vh;
  padding: 24px 0;
}
.error-card {
  width: 92%;
  max-width: 700px;
  background: linear-gradient(180deg, #201018, #2a1518);
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  color: #ffdede;
  border: 1px solid rgba(255, 0, 0, 0.08);
}
.error-text {
  color: #ffdede;
  font-size: 16px;
  margin-bottom: 12px;
}
.error-actions {
  display: flex;
  justify-content: center;
  gap: 12px;
}
</style>
