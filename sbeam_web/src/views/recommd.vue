<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const recommendedPosts = ref([]) // 存储推荐的帖子
const recommendedGames = ref([]) // 存储推荐的游戏

// 获取推荐内容的函数
const getRecommendations = async () => {
  try {
    const token = localStorage.getItem('sbeam_token') // 获取存储在 localStorage 中的 token

    if (!token) {
      alert('请先登录')
      return
    }

    // 向 Flask 后端的 /recommend 接口发送请求
    const response = await axios.post(
      'http://127.0.0.1:5000/recommend',
      {},
      {
        headers: {
          Authorization: `Bearer ${token}`, // 在请求头中添加 token
        },
      },
    )

    // 获取推荐的帖子和游戏
    if (response.data) {
      recommendedPosts.value = response.data.recommendedPosts
      recommendedGames.value = response.data.recommendedGames
    } else {
      alert('没有推荐内容')
    }
  } catch (error) {
    console.error('获取推荐失败', error)
    alert('获取推荐失败')
  }
}

// 这里可以添加其他逻辑，例如页面加载时获取推荐内容
</script>

<template>
  <div>
    <h3>推荐内容</h3>
    <button @click="getRecommendations">获取推荐内容</button>

    <div v-if="recommendedPosts.length > 0">
      <h4>推荐帖子：</h4>
      <ul>
        <li v-for="(post, index) in recommendedPosts" :key="index">
          {{ post.postTitle }} - Likes: {{ post.likeCount }}
        </li>
      </ul>
    </div>

    <div v-if="recommendedGames.length > 0">
      <h4>推荐游戏：</h4>
      <ul>
        <li v-for="(game, index) in recommendedGames" :key="index">Game ID: {{ game }}</li>
      </ul>
    </div>
  </div>
</template>
