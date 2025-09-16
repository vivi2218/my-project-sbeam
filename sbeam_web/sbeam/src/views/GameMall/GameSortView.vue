<template>
  <div class="game-sort">
    <h1>游戏排序</h1>
    <div class="sort-buttons">
      <button @click="sortBy('rating')">按评分</button>
      <button @click="sortBy('price')">按价格</button>
      <button @click="sortBy('releaseDate')">按发布时间</button>
    </div>

    <ul>
      <li v-for="game in sortedGames" :key="game.id">
        {{ game.name }} - 评分: {{ game.rating }} - ￥{{ game.price }} - {{ game.releaseDate }}
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";

const games = ref([
  { id: 1, name: "塞尔达传说", rating: 9.5, price: 299, releaseDate: "2023-12-01" },
  { id: 2, name: "使命召唤", rating: 8.7, price: 399, releaseDate: "2024-05-01" },
  { id: 3, name: "原神", rating: 9.0, price: 0, releaseDate: "2020-09-28" },
]);

const currentSort = ref("rating");

function sortBy(key: string) {
  currentSort.value = key;
}

const sortedGames = computed(() => {
  return [...games.value].sort((a, b) => {
    if (currentSort.value === "rating") return b.rating - a.rating;
    if (currentSort.value === "price") return a.price - b.price;
    if (currentSort.value === "releaseDate")
      return new Date(b.releaseDate).getTime() - new Date(a.releaseDate).getTime();
    return 0;
  });
});
</script>

<style scoped>
.sort-buttons {
  margin-bottom: 20px;
}
button {
  margin-right: 10px;
  padding: 6px 12px;
  border: none;
  background: #42b983;
  color: #fff;
  cursor: pointer;
}
button:hover {
  background: #2e805d;
}
</style>
