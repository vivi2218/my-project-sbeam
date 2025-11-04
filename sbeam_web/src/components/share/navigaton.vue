<template>
  <div id="navigationStyle">
    <!-- 顶部导航 -->
    <header>
      <span class="brand">
        <!-- <img src=" class="" /> -->
        <div class="logo">Sbeam</div>
      </span>

      <div class="search-container">
        <input
          v-model="keyword"
          type="text"
          class="search-input"
          placeholder="请输入关键词搜索..."
          @keyup.enter="search"
        />
        <button class="search-btn" @click="search">🔍 搜索</button>

        <!-- 搜索结果 -->
        <div class="results" v-if="results.length > 0">
          <h3>搜索结果：</h3>
          <div class="result-list">
            <div
              v-for="item in results"
              :key="item.gameId"
              class="result-item"
              @click="goToGame(item.gameId, $event)"
            >
              <strong>{{ item.gameName }}</strong> - {{ item.gameOriginalPrice }} 元
            </div>
          </div>
        </div>

        <div v-else-if="searched">没有找到结果</div>
      </div>
      <nav>
        <router-link to="/" class="btn-cute">首页</router-link>
        <router-link to="/store" class="btn-cute">商城</router-link>
        <router-link to="/User/cart" class="btn-cute">购物车</router-link>
        <router-link to="/User/myorder" class="btn-cute">我的订单</router-link>
        <router-link to="/forum" class="btn-cute">社区</router-link>

        <a href="#" class="btn-cute" @click.prevent="goUserHome">个人中心</a>
      </nav>
    </header>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { ref } from 'vue'
import axios from 'axios'

const router = useRouter()
const keyword = ref('')
const results = ref<any[]>([])
const searched = ref(false)

const goUserHome = (e?: Event) => {
  if (e) e.preventDefault()
  const token = localStorage.getItem('sbeam_token')
  if (token) {
    router.push('/homeuser')
  } else {
    router.push('/login')
  }
}

const search = async () => {
  const key = keyword.value.trim()
  if (!key) return

  searched.value = false
  results.value = []

  try {
    const res = await fetch(`http://localhost:8080/search?keyword=${encodeURIComponent(key)}`)
    if (!res.ok) throw new Error('请求失败')
    results.value = await res.json()
  } catch (err) {
    console.error('搜索失败：', err)
  } finally {
    searched.value = true
  }
}

function goToGame(id: number, event?: MouseEvent) {
  console.log('跳转到游戏', id)
  if (event) event.stopPropagation()
  router.push({ name: 'game-detail', params: { id } })
}
</script>

<style scoped src="../../assets/Share/Navigation.css">
.search-container {
  width: 400px;
  top: 50px;
  margin: 50px auto;
  text-align: center;
}
.search-input {
  width: 250px;
  padding: 8px;
  border-radius: 8px;
  border: 1px solid #ccc;
}
.search-btn {
  padding: 8px 12px;
  margin-left: 8px;
  border: none;
  background-color: #4caf50;
  color: white;
  border-radius: 8px;
  cursor: pointer;
}
.results {
  text-align: left;
  margin-top: 20px;
}
.result-item {
  cursor: pointer;
}
</style>
