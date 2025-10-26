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
      <div class="right right-meta">
        <h1>{{ gameDetail.gameName }}</h1>
        <div class="meta-row">
          <span class="tag">{{ gameDetail.gameProfile?.gameTagName }}</span>
          <span class="tag" v-if="gameDetail.gameProfile?.series">系列：{{ gameDetail.gameProfile.series }}</span>
        </div>
  <p class="muted">开发商：{{ gameDetail.gameProfile?.gameDeveloper }}</p>
  <p class="muted">发行日期：{{ formattedReleaseDate }}</p>
  <p class="desc">{{ gameDetail.gameProfile?.gameDescription }}</p>

        <div class="price-row">
          <div class="price">{{ gameDetail.gameOriginalPrice }} $</div>
          <div class="original-price" v-if="gameDetail.priceHistory && gameDetail.priceHistory.length">历史价：{{ gameDetail.priceHistory[0].price }} $</div>
        </div>

        <div class="buy-actions">
          <!-- <button class="buy-btn">立即购买</button> -->
          <button class="cart-btn" @click="addToCart">加入购物车</button>
          <button class="wishlist-btn" @click="toggleFollow">{{ gameDetail.userFollowed ? '已关注' : '关注' }}</button>
        </div>
      </div>
    </div>

    <!-- 游戏图片展示 -->
    <div class="game-images">
      <h2>游戏截图</h2>
      <div class="image-list">
        <img v-for="(image, index) in (gameDetail.gameImages || [])" :key="index" :src="image" :alt="image" class="image-item" />
      </div>
    </div>

    <!-- 捆绑包展示 -->
    <div class="game-bundles">
      <h2>捆绑包</h2>
      <div v-for="bundle in gameDetail.gameBundles" :key="bundle.bundleName">
        <p><strong>{{ bundle.bundleName }}</strong></p>
        <p>{{ bundle.discountPolicy }}</p>
      </div>
    </div>

    <!-- 价格历史 -->
    <div class="price-history">
      <h2>价格历史</h2>
      <div v-for="(history, idx) in (gameDetail.priceHistory || [])" :key="idx">
        <p>日期：{{ formatDate(history.priceDate) }} - 价格：{{ history.price }} USD</p>
      </div>
    </div>

    <!-- 游戏成就 -->
    <div class="game-achievements">
      <h2>游戏成就</h2>
      <div v-for="achievement in gameDetail.gameAchievements" :key="achievement.achievementName">
        <p><strong>{{ achievement.achievementName }}</strong>: {{ achievement.achievementDescription }}</p>
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

    <!-- 用户关注状态 加入购物车按钮
    <div class="user-follow">
      <button @click="toggleFollow">
        {{ gameDetail.userFollowed ? "取消关注" : "关注游戏" }}
      </button>
    </div>

    <div class="add-to-cart">
      <button @click="addToCart">
        加入购物车
      </button>
    </div> -->
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import axios from 'axios';

interface GameDetail {
  releaseDate?: number[];
  mainImageUrl?: string;
  gameName?: string;
  gameOriginalPrice?: number | string;
  gameImages?: string[];
  gameBundles?: Array<{ bundleName: string; discountPolicy?: string }>;
  priceHistory?: Array<{ priceDate: number[]; price: number }>;
  gameAchievements?: Array<{ achievementName: string; achievementDescription?: string }>;
  gameProfile?: { gameDeveloper?: string; gameTagName?: string; gameConfig?: string; series?: string; gameDescription?: string };
  userFollowed?: boolean;
}

const gameDetail = ref<GameDetail>({});
const loading = ref<boolean>(true);
const error = ref<string>('');

const formattedReleaseDate = computed(() => {
  const d = gameDetail.value.releaseDate;
  return d ? `${d[0]}-${d[1]}-${d[2]}` : '';
});

function formatDate(dateArray) {
  return `${dateArray[0]}-${dateArray[1]}-${dateArray[2]}`;
}

function toggleFollow() {
  if (!gameDetail.value) return;
  gameDetail.value.userFollowed = !gameDetail.value.userFollowed;
}
function addToCart() {
  alert('已将游戏加入购物车！');
}

async function fetchGameDetails() {
  loading.value = true;
  error.value = '';
  try {
    const res = await axios.get('http://localhost:8080/game/details/1');
    // 支持两种后端结构：{ data: { data: {...} } } 或 { data: {...} }
    const payload = res.data?.data ?? res.data;
    if (!payload) throw new Error('后端返回空数据');
    gameDetail.value = payload;
  } catch (err: unknown) {
    console.error('获取游戏详情失败:', err);
  const maybeErr = err as { message?: string } | undefined;
  const msg = maybeErr && maybeErr.message ? maybeErr.message : String(err);
    error.value = msg || '获取游戏详情失败，请稍后重试';
  } finally {
    loading.value = false;
  }
}

onMounted(() => {
  fetchGameDetails();
});
</script>

<style scoped>
/* 根变量定义 */
:root {
  --primary-bg: #1b2d39;
  --card-bg: #223543;
  --text-primary: #e3f2fd;
  --text-secondary: #b0bec5;
  --text-muted: #78909c;
  --accent-primary: #4fc3f7;
  --accent-secondary: #29b6f6;
  --success: #81c784;
  --warning: #ffb74d;
  --danger: #e57373;
  --border: #37474f;
  --radius: 8px;
}

/* 游戏详情页容器 */
.game-detail {
  background: var(--primary-bg);
  color: var(--text-primary);
  min-height: 100vh;
  padding: 20px;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* 游戏基本信息区域 */
.game-info {
  display: flex;
  gap: 30px;
  background: var(--card-bg);
  padding: 25px;
  border-radius: var(--radius);
  margin-bottom: 25px;
  border: 1px solid var(--border);
}

.game-info .left {
  flex: 0 0 300px;
}

.main-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: var(--radius);
  border: 1px solid var(--border);
}

.game-info .right {
  flex: 1;
}

.game-info h1 {
  color: var(--text-primary);
  font-size: 2.2em;
  margin-bottom: 15px;
  font-weight: 700;
}

/* 元信息行 */
.meta-row {
  display: flex;
  gap: 12px;
  margin-bottom: 15px;
  flex-wrap: wrap;
}

.tag {
  background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
  color: var(--primary-bg);
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 0.85em;
  font-weight: 600;
}

.muted {
  color: var(--text-muted);
  margin: 8px 0;
  font-size: 0.95em;
}

.desc {
  color: var(--text-secondary);
  line-height: 1.6;
  margin: 15px 0;
  font-size: 1em;
}

/* 价格行 */
.price-row {
  display: flex;
  align-items: center;
  gap: 20px;
  margin: 20px 0;
  padding: 15px 0;
  border-top: 1px solid var(--border);
  border-bottom: 1px solid var(--border);
}

.price {
  color: var(--accent-primary);
  font-size: 1.8em;
  font-weight: bold;
}

.original-price {
  color: var(--text-muted);
  text-decoration: line-through;
  font-size: 1.1em;
}

/* 购买操作按钮 */
.buy-actions {
  display: flex;
  gap: 15px;
  margin-top: 25px;
}

.cart-btn, .wishlist-btn {
  padding: 12px 30px;
  border: none;
  border-radius: var(--radius);
  font-size: 1em;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cart-btn {
  background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
  color: var(--primary-bg);
}

.cart-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(79, 195, 247, 0.3);
}

.wishlist-btn {
  background: rgba(255, 255, 255, 0.1);
  color: var(--text-primary);
  border: 1px solid var(--border);
}

.wishlist-btn:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: var(--accent-primary);
}

/* 已关注状态 */
.wishlist-btn[style*="已关注"] {
  background: var(--success);
  color: var(--primary-bg);
  border-color: var(--success);
}

/* 各内容区块通用样式 */
.game-images,
.game-bundles,
.price-history,
.game-achievements,
.game-profile {
  background: var(--card-bg);
  padding: 25px;
  border-radius: var(--radius);
  margin-bottom: 25px;
  border: 1px solid var(--border);
}

/* 区块标题 */
h2 {
  color: var(--text-primary);
  font-size: 1.5em;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid var(--accent-primary);
  font-weight: 600;
}

/* 游戏图片展示 */
.image-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 15px;
}

.image-item {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: var(--radius);
  border: 1px solid var(--border);
  transition: transform 0.3s ease;
}

.image-item:hover {
  transform: scale(1.03);
}

/* 捆绑包样式 */
.game-bundles p {
  margin: 10px 0;
  color: var(--text-secondary);
}

.game-bundles strong {
  color: var(--accent-primary);
}

/* 价格历史样式 */
.price-history p {
  padding: 8px 12px;
  margin: 5px 0;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 4px;
  color: var(--text-secondary);
  border-left: 3px solid var(--accent-primary);
}

/* 游戏成就样式 */
.game-achievements p {
  padding: 12px;
  margin: 8px 0;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 6px;
  border: 1px solid var(--border);
  color: var(--text-secondary);
}

.game-achievements strong {
  color: var(--warning);
}

/* 游戏详情样式 */
.game-profile p {
  margin: 12px 0;
  color: var(--text-secondary);
  line-height: 1.5;
}

.game-profile strong {
  color: var(--text-primary);
  font-weight: 600;
}

</style>

