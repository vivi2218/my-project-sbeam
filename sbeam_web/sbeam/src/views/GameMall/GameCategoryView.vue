<template>
  <div class="category-page">
    <h1>游戏分类</h1>

    <div class="category-container">
      <div
        class="category-card"
        v-for="c in categories"
        :key="c"
        @click="goToCategory(c)"
      >
        {{ c }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from "vue-router"

const router = useRouter()

// 游戏分类数据
const categories: string[] = [
  "动作",
  "冒险",
  "角色扮演 (RPG)",
  "策略",
  "射击",
  "体育竞速",
]

// 点击分类 → 跳转到搜索/排序页面（未来可传参）
const goToCategory = (category: string) => {
  router.push({ path: "/games/sort", query: { category } })
}
</script>

<style scoped>
.category-page {
  padding: 20px;
}

.category-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.category-card {
  background: #fff;
  padding: 40px 20px;
  text-align: center;
  font-size: 18px;
  border-radius: 10px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: all 0.3s ease;
}

.category-card:hover {
  background: #007bff;
  color: #fff;
  transform: translateY(-5px);
}
</style>
