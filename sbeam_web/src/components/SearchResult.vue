<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const keyword = ref(route.query.keyword as string || '')
const results = ref<Array<any>>([])

// 搜索接口
const fetchResults = async () => {
  if (!keyword.value) return
  try {
    const res = await axios.get(`http://localhost:8080/search/search`, {
      params: { keyword: keyword.value }
    })
    console.log('搜索结果：', res.data)

    // 处理游戏图片路径
    results.value = res.data.map((item: any) => {
      if (item.type === 'game' && item.gameId) {
        return {
          ...item,
          imageUrl: `/gameimg/${item.gameId}.jpg`
        }
      }
      // 其他类型保持原样
      return { ...item, imageUrl: item.imageUrl || null }
    })
  } catch (err) {
    console.error('搜索失败', err)
    results.value = []
  }
}

onMounted(fetchResults)

// query.keyword 改变时重新搜索
watch(() => route.query.keyword, (newKeyword) => {
  keyword.value = newKeyword as string
  fetchResults()
})

// 点击搜索结果跳转
const goToDetail = (item: any) => {
  if (item.type === 'game') {
    router.push({ name: 'game-detail', params: { id: item.gameId } })
  } else if (item.type === 'community') {
    router.push({ name: 'community-detail', params: { id: item.communityId } })
  }
  // 可以继续添加其他类型
}
</script> 

<template>
  <div>
    <h2>搜索结果：{{ keyword }}</h2>
    <div v-if="results.length === 0">暂无结果</div>
    <ul v-else>
      <li
        v-for="item in results"
        :key="item.type + '-' + (item.gameId || item.id)"
        @click="goToDetail(item)"
        style="cursor:pointer; margin-bottom: 15px;"
      >
        <h3>{{ item.gameName || item.name }}</h3>
        <img
          v-if="item.imageUrl"
          :src="item.imageUrl"
          :alt="item.gameName || item.name"
          width="200"
          style="display:block; margin-bottom:5px;"
        />
        <p v-else style="color:#888;">暂无图片</p>
        <p style="font-size: 14px; color:#555;">类型: {{ item.type }}</p>
        <p v-if="item.gameOriginalPrice">原价: {{ item.gameOriginalPrice }}</p>
      </li>
    </ul>
  </div>
</template>
