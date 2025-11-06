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

const visibleCount = 6       // 一次显示 6 个
const itemWidth = 200        // 每个元素宽度
const transitionTime = 1000   // ms

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
    <div class="sol">
      <div class="sol-image">图片</div>
      <div class="sol-description">描述</div>
    </div>



    <div>
      <span>根据您的喜好推荐：</span>
      <div class="like">
        <div class="like-track" :style="{
          transform: `translateX(-${currentIndex * itemWidth}px)`,
          transition: isTransitioning ? `transform ${transitionTime}ms ease-in-out` : 'none'
        }" @transitionend="handleTransitionEnd">
          <div class="like-item" v-for="(item, index) in displayItems" :key="index">
            {{ item }}
          </div>
        </div>
      </div>
    </div>

    <div>
      <span>社区中的新内容</span>
        <div>post1</div>

    </div>

  </div>
</template>

<style>


.sol {
  width: 1200px;
  height: 400px;
  background-color: rgb(117, 117, 117);
  display: flex;
  /* 使用 flex 布局 */
  justify-content: space-between;
  /* 图片和描述分开 */
  align-items: center;
  /* 垂直居中 */
  padding: 20px;
  margin: auto;
}

.sol-image {
  flex: 0 0 400px;
  /* 保证图片宽度 */
  height: 380px;
  /* 设置图片的高度 */
  background-color: #f8cccc;
}

.sol-description {
  flex: 1;
  /* 剩余空间分配给描述 */
  padding-left: 20px;
  /* 给描述一些左侧的间距 */
  font-size: 18px;
  color: #fff;
}

.home-view {
  padding-top: 40px;
  width: 1350px;
  height: 100%;
  text-align: center;
  color: #fff;
  background-color: rgba(43, 43, 43, 0.745);
}

.like {
  width: 1200px;
  /* 显示 3 个元素 */
  overflow: hidden;
  background-color: rgba(52, 52, 52, 0.746);
  margin: 20px auto 0;
}

.like-track {
  display: flex;
}

.like-item {
  flex: 0 0 200px;
  height: 250px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(255, 255, 255, 0.1);
  font-size: 18px;
}
</style>
