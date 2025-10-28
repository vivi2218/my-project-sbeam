<script setup lang="ts">
import { ref, onMounted, onUnmounted, nextTick } from 'vue'

const hotItems = ref([
  '热门游戏 1',
  '热门游戏 2',
  '热门游戏 3',
  '热门游戏 4',
  '热门游戏 5',
  '热门游戏 6',
])

const visibleCount = 3       // 一次显示 3 个
const itemWidth = 400        // 每个元素宽度
const transitionTime = 500   // ms

// 克隆前 visibleCount 个元素，实现无缝滚动
const displayItems = ref([...hotItems.value, ...hotItems.value.slice(0, visibleCount)])

const currentIndex = ref(0)
let timer: number | undefined
const isTransitioning = ref(true)

const startScroll = () => {
  timer = window.setInterval(() => {
    nextTick(() => {
      currentIndex.value++
      isTransitioning.value = true
    })
  }, 2000)
}

const handleTransitionEnd = () => {
  // 如果滚动到克隆的元素，瞬间重置回原始元素
  if (currentIndex.value >= hotItems.value.length) {
    isTransitioning.value = false // 关闭过渡
    currentIndex.value = 0         // 重置位置
  }
}

onMounted(() => startScroll())
onUnmounted(() => { if (timer) clearInterval(timer) })
</script>

<template>
  <div class="home-view">
    <span>今日势头最猛</span>
    <div class="carousel">
      <div
        class="carousel-track"
        :style="{
          transform: `translateX(-${currentIndex * itemWidth}px)`,
          transition: isTransitioning ? `transform ${transitionTime}ms ease-in-out` : 'none'
        }"
        @transitionend="handleTransitionEnd"
      >
        <div
          class="carousel-item"
          v-for="(item, index) in displayItems"
          :key="index"
        >
          {{ item }}
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.home-view {
  padding-top: 40px;
  width: 1350px;
  height: 100%;
  text-align: center;
  color: #fff;
  background-color: rgba(43, 43, 43, 0.745);
}

.carousel {
  width: 1200px;          /* 显示 3 个元素 */
  overflow: hidden;
  background-color: rgba(52, 52, 52, 0.746);
  margin: 20px auto 0;
}

.carousel-track {
  display: flex;
}

.carousel-item {
  flex: 0 0 400px;
  height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(255, 255, 255, 0.1);
  font-size: 18px;
}
</style>
