<template>
  <div class="store-page">
    <!-- 顶部搜索和排序 -->
    <div class="store-header">
      <input
        v-model="keyword"
        class="search-input"
        placeholder="搜索游戏..."
        @focus="searchFocus"
        @blur="searchBlur"
      />
      <select v-model="sortType" class="sort-select">
        <option value="rating">按评分</option>
        <option value="price">按价格</option>
        <option value="date">按发布时间</option>
      </select>
    </div>

    <div class="store-content">
      <!-- 左侧分类 -->
      <aside class="category-list">
        <h3>游戏分类</h3>
        <ul>
          <li
            v-for="c in categories"
            :key="c"
            @click="selectCategory(c)"
            :class="{ active: c === activeCategory }"
          >
            <span class="category-dot"></span>
            {{ c }}
          </li>
        </ul>
      </aside>

      <!-- 右侧游戏展示 -->
      <main class="game-list">
        <!-- 空状态处理 -->
        <div v-if="filteredGames.length === 0" class="empty-state">
          <img src="../../public/cyber.png" alt="暂无游戏" class="empty-img" />
          <p>没有找到符合条件的游戏</p>
        </div>

        <div
          v-for="game in filteredGames"
          :key="game.gameId"
          class="game-card"
          @click="goGameDetail(game.gameId)"
        >
          <div class="game-img-wrapper">
            <img
              :src="`/gameimg/${game.gameId}.jpg`"
              alt="封面"
              @error="onImageError"
              class="game-img"
            />
            <div class="game-rating-badge">{{ game.rating }}</div>
          </div>
          <div class="info">
            <h4 class="game-title">{{ game.gameName }}</h4>
            <div class="game-tags">
              <span v-for="tag in game.gameTagName?.split(',')" :key="tag" class="game-tag">
                {{ tag.trim() }}
              </span>
            </div>
            <p class="price">￥{{ game.gameOriginalPrice }}</p>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import router from '../router/index'

const keyword = ref('')
const sortType = ref('rating')
const activeCategory = ref('全部')
const categories = ref(['全部'])
const gameList = ref([])
const isSearchFocused = ref(false)

// 搜索框焦点状态
const searchFocus = () => (isSearchFocused.value = true)
const searchBlur = () => (isSearchFocused.value = false)

// 页面加载时获取游戏数据
onMounted(async () => {
  try {
    const res = await axios.get('http://localhost:8080/game/games')
    gameList.value = res.data.data || []

    // 提取所有游戏的标签并去重
    const tagSet = new Set()
    gameList.value.forEach((game) => {
      if (game.gameTagName) {
        const tags = game.gameTagName.split(',')
        tags.forEach((tag) => tagSet.add(tag.trim()))
      }
    })

    categories.value.push(...Array.from(tagSet))
  } catch (err) {
    console.error('获取游戏数据失败:', err)
  }
})

// 处理图片加载失败
const onImageError = (e) => {
  e.target.src = '/gameimg/default.jpg'
}

// 搜索 + 分类 + 排序逻辑
const filteredGames = computed(() => {
  let result = gameList.value.filter((g) =>
    g.gameName.toLowerCase().includes(keyword.value.toLowerCase()),
  )

  if (activeCategory.value !== '全部') {
    result = result.filter((g) =>
      g.gameTagName?.toLowerCase().includes(activeCategory.value.toLowerCase()),
    )
  }

  // 排序处理（复制数组避免修改原数组）
  const sorted = [...result]
  switch (sortType.value) {
    case 'price':
      sorted.sort((a, b) => a.gameOriginalPrice - b.gameOriginalPrice)
      break
    case 'date':
      sorted.sort((a, b) => new Date(b.releaseDate) - new Date(a.releaseDate))
      break
    default: // rating
      sorted.sort((a, b) => b.rating - a.rating)
  }

  return sorted
})

function selectCategory(c) {
  activeCategory.value = c
  // 滚动到顶部，优化体验
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

function goGameDetail(id) {
  router.push({ name: 'game-detail', params: { id } })
}
</script>

<style scoped>
/* 基础样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html,
body,
#app {
  min-height: 100vh;
  background-color: #0f0f0f;
  color: #e0e0e0;
  overflow-y: auto;
}

.store-page {
  max-width: 1600px; /* 增加页面最大宽度，提供更大展示空间 */
  width: 100%;
  margin: 0 auto;
  padding: 24px;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

/* 顶部搜索排序区 */
.store-header {
  display: flex;
  gap: 16px;
  margin-bottom: 32px;
  align-items: center;
}

.search-input {
  flex: 1;
  padding: 12px 16px;
  background: #1e1e1e;
  border: 1px solid #333;
  color: #fff;
  border-radius: 8px;
  font-size: 14px;
  transition: all 0.3s ease;
}

.search-input:focus {
  outline: none;
  border-color: #66ccff;
  box-shadow: 0 0 0 2px rgba(102, 204, 255, 0.2);
}

.sort-select {
  padding: 12px 16px;
  background: #1e1e1e;
  border: 1px solid #333;
  color: #fff;
  border-radius: 8px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.sort-select:focus {
  outline: none;
  border-color: #66ccff;
}

/* 内容区域布局 */
.store-content {
  display: flex;
  gap: 24px;
}

/* 分类列表样式 */
.category-list {
  width: 200px;
  background: #181818;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  height: fit-content;
}

.category-list h3 {
  color: #f0f0f0;
  margin-bottom: 16px;
  padding-bottom: 8px;
  border-bottom: 1px solid #333;
  font-size: 16px;
}

.category-list ul {
  list-style: none;
}

.category-list li {
  padding: 10px 12px;
  margin-bottom: 6px;
  cursor: pointer;
  border-radius: 6px;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.2s ease;
  font-size: 14px;
}

.category-list li:hover {
  background: #252525;
  color: #66ccff;
}

.category-list li.active {
  background: #2d2d2d;
  color: #66ccff;
  font-weight: 500;
}

.category-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #66ccff;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.category-list li.active .category-dot {
  opacity: 1;
}

/* 游戏列表样式 - 关键调整：减小卡片宽度，增加每行显示数量 */
.game-list {
  flex: 1;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); /* 减小卡片宽度 */
  gap: 20px; /* 减小间距 */
}

/* 空状态样式 */
.empty-state {
  grid-column: 1 / -1;
  text-align: center;
  padding: 60px 20px;
  color: #888;
}

.empty-img {
  width: 120px;
  margin-bottom: 16px;
  opacity: 0.5;
}

/* 游戏卡片样式 - 关键调整：缩小卡片整体尺寸 */
.game-card {
  background: #181818;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  display: flex;
  flex-direction: column;
  height: 300px; /* 确保卡片高度一致 */
  max-height: 380px; /* 限制最大高度，防止过长 */
}

.game-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
}

/* 游戏图片容器 - 调整比例 */
.game-img-wrapper {
  position: relative;
  width: 100%;
  padding-top: 135%; /* 调整为1:1.35比例，略短于之前 */
  overflow: hidden;
}

.game-img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.game-card:hover .game-img {
  transform: scale(1.08);
}

/* 评分徽章 */
.game-rating-badge {
  position: absolute;
  bottom: 8px;
  right: 8px;
  background: rgba(0, 0, 0, 0.7);
  color: #ffd700;
  padding: 2px 6px;
  border-radius: 10px;
  font-size: 11px;
  font-weight: bold;
}

/* 游戏信息区域 - 缩小内边距和字体 */
.info {
  padding: 12px; /* 减小内边距 */
  flex: 1;
  height: 80px;
  display: flex;
  flex-direction: column;
  overflow: hidden; /* 防止内容溢出 */
}

.game-title {
  color: #fff;
  font-size: 14px; /* 缩小字体 */
  margin-bottom: 6px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 游戏标签 */
.game-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 3px;
  height: 20px;
  margin-bottom: 8px;
  max-height: 40px; /* 限制标签区域高度，防止过多标签导致卡片过长 */
  overflow: hidden;
}

.game-tag {
  font-size: 11px; /* 缩小标签字体 */
  padding: 1px 6px;
  background: #2d2d2d;
  border-radius: 3px;
  color: #bbb;
  height: 100%;
}

.price {
  color: #ffcc66;
  font-size: 13px; /* 缩小价格字体 */
  font-weight: 500;
  height: 10px;
  /* margin-top: auto; 价格靠下对齐 */
}

/* 响应式调整 */
@media (max-width: 1024px) {
  .store-content {
    flex-direction: column;
  }

  .category-list {
    width: 100%;
  }

  .category-list ul {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }

  .category-list li {
    margin-bottom: 0;
  }
}

@media (max-width: 768px) {
  .game-list {
    grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
  }

  .store-header {
    flex-direction: column;
    align-items: stretch;
  }

  .sort-select {
    margin-left: 0;
  }
}
</style>
