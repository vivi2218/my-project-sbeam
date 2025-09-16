<template>
  <div class="game-search">
    <h1>游戏搜索</h1>
    <input v-model="keyword" type="text" placeholder="输入游戏名或关键字" />

    <ul>
      <li v-for="game in filteredGames" :key="game.id">
        {{ game.name }} - 评分: {{ game.rating }} - ￥{{ game.price }}
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";

const keyword = ref("");

const games = ref([
  { id: 1, name: "塞尔达传说", rating: 9.5, price: 299 },
  { id: 2, name: "使命召唤", rating: 8.7, price: 399 },
  { id: 3, name: "原神", rating: 9.0, price: 0 },
  { id: 4, name: "极品飞车", rating: 8.2, price: 249 },
]);

const filteredGames = computed(() => {
  return games.value.filter((g) =>
    g.name.toLowerCase().includes(keyword.value.toLowerCase())
  );
});
</script>

<style scoped>
input {
  padding: 8px;
  margin-bottom: 20px;
  width: 300px;
}
</style>
