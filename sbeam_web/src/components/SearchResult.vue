<template>
  <div class="search-result">
    <div class="search-box">
      <input
        v-model="keyword"
        type="text"
        placeholder="搜索游戏或社区..."
        @keyup.enter="handleSearch"
      >
      <button @click="handleSearch">搜索</button>
    </div>

    <div class="results" v-if="searchResults.length > 0">
      <div
        v-for="item in searchResults"
        :key="item.type + (item.gameId || item.communityId)"
        class="result-item"
        @click="handleItemClick(item)"
      >
        <div class="item-type">{{ item.type === 'game' ? '游戏' : '社区' }}</div>
        <div class="item-content">
          <template v-if="item.type === 'game'">
            <h3>{{ item.gameName }}</h3>
            <p class="price">￥{{ item.gameOriginalPrice }}</p>
          </template>
          <template v-else>
            <h3>{{ item.communityName }}</h3>
            <p class="description">{{ item.communityDescription }}</p>
          </template>
        </div>
      </div>
    </div>
    <div v-else-if="hasSearched" class="no-results">
      未找到相关结果
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const keyword = ref('')
const searchResults = ref([])
const hasSearched = ref(false)

const handleSearch = async () => {
  if (!keyword.value.trim()) return

  try {
    const response = await axios.get(`/api/search?keyword=${encodeURIComponent(keyword.value)}`)
    searchResults.value = response.data
    hasSearched.value = true
  } catch (error) {
    console.error('搜索失败:', error)
  }
}

const handleItemClick = (item) => {
  if (item.type === 'game') {
    router.push(`/game/${item.gameId}`)
  } else {
    router.push(`/community/${item.communityId}`)
  }
}
</script>

<style scoped>
.search-result {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}

.search-box {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.search-box input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
}

.search-box button {
  padding: 10px 20px;
  background-color: #4a90e2;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.search-box button:hover {
  background-color: #357abd;
}

.result-item {
  display: flex;
  padding: 15px;
  border: 1px solid #eee;
  margin-bottom: 10px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.result-item:hover {
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  border-color: #4a90e2;
}

.item-type {
  background-color: #f0f0f0;
  padding: 4px 8px;
  border-radius: 4px;
  margin-right: 15px;
  height: fit-content;
  font-size: 14px;
}

.item-content {
  flex: 1;
}

.item-content h3 {
  margin: 0 0 8px 0;
  color: #333;
}

.price {
  color: #e53935;
  font-weight: bold;
  margin: 0;
}

.description {
  color: #666;
  margin: 0;
  font-size: 14px;
}

.no-results {
  text-align: center;
  color: #666;
  padding: 20px;
}
</style>
