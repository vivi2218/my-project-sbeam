<template>
  <div class="store-page">
    <!-- 顶部搜索和排序 -->
    <div class="store-header">
      <input v-model="keyword" class="search-input" placeholder="搜索游戏..." />
      <select v-model="sortType" class="sort-select">
        <option value="rating">按评分</option>
        <option value="price">按价格</option>
        <option value="date">按发布时间</option>
      </select>
    </div>

    <div class="store-content">
      <!-- 左侧分类 -->
      <aside class="category-list">
        <h3>分类</h3>
        <ul>
          <li v-for="c in categories" :key="c" @click="selectCategory(c)" :class="{ active: c === activeCategory }">
            {{ c }}
          </li>
        </ul>
      </aside>

      <!-- 右侧游戏展示 -->
      <main class="game-list">
        <div v-for="game in filteredGames" :key="game.id" class="game-card"  @click="goGameDetail(game.id)">
          <img :src="game.cover" alt="封面" />
          <div class="info">
            <h4>{{ game.name }}</h4>
            <p class="rating">评分：{{ game.rating }}</p>
            <p class="price">价格：￥{{ game.price }}</p>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import router from '../router/index';




const keyword = ref("");
const sortType = ref("rating");
const activeCategory = ref("全部");

const categories = ["全部", "动作", "冒险", "角色扮演", "策略", "射击"];

const gameList = ref([
  { id: 1, name: "暗影突袭", category: "动作", rating: 9.2, price: 99, cover: "https://picsum.photos/200/300?random=1" },
  { id: 2, name: "秘境探险", category: "冒险", rating: 8.7, price: 79, cover: "https://picsum.photos/200/300?random=2" },
  { id: 3, name: "王国之心", category: "角色扮演", rating: 9.5, price: 129, cover: "https://picsum.photos/200/300?random=3" },
  { id: 4, name: "银河战士", category: "射击", rating: 8.9, price: 89, cover: "https://picsum.photos/200/300?random=4" },
  { id: 5, name: "帝国征服", category: "策略", rating: 8.4, price: 69, cover: "https://picsum.photos/200/300?random=5" },
]);

// 分类 + 搜索 + 排序
const filteredGames = computed(() => {
  let result = gameList.value.filter((g) =>
    g.name.includes(keyword.value)
  );
  if (activeCategory.value !== "全部") {
    result = result.filter((g) => g.category === activeCategory.value);
  }
  if (sortType.value === "rating") {
    result.sort((a, b) => b.rating - a.rating);
  } else if (sortType.value === "price") {
    result.sort((a, b) => a.price - b.price);
  }
  return result;
});

function selectCategory(c) {
  activeCategory.value = c;
}
// 点击跳转游戏详情
function goGameDetail(id) {
  router.push({ name: "game-detail", params: { id } });
}
</script>

<style scoped>
.store-page { 
  position :relative;
  top: 38px;
  max-width: 100vw;
  width: 1200px;
  height: 95%;
  background-color: #121212;
  color: #e0e0e0;
  min-height: 100vh;
  padding: 20px;
  flex: 100%;
  font-family: "Microsoft YaHei", sans-serif;
}

/* 顶部栏 */
.store-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.search-input {
  flex: 1;
  padding: 8px;
  background: #1e1e1e;
  border: 1px solid #333;
  color: #fff;
  border-radius: 6px;
}

.sort-select {
  margin-left: 10px;
  padding: 8px;
  background: #1e1e1e;
  border: 1px solid #333;
  color: #fff;
  border-radius: 6px;
}

/* 内容布局 */
.store-content {
  display: flex;
  gap: 20px;
}

/* 分类 */
.category-list {
  width: 180px;
  background: #1c1c1c;
  padding: 15px;
  border-radius: 10px;
}

.category-list ul {
  list-style: none;
  padding: 0;
}

.category-list li {
  padding: 6px;
  cursor: pointer;
  border-radius: 6px;
}

.category-list li:hover,
.category-list li.active {
  background: #2d2d2d;
}

/* 游戏卡片 */
.game-list {
  flex: 1;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 16px;
}

.game-card {
  background: #1e1e1e;
  border-radius: 10px;
  overflow: hidden;
  transition: 0.3s;
}

.game-card:hover {
  transform: translateY(-5px);
}

.game-card img {
  width: 100%;
  height: 220px;
  object-fit: cover;
}

.info {
  padding: 10px;
}

.rating {
  color: #66cc66;
}

.price {
  color: #ffcc66;
}
</style>
