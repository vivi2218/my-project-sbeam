<script setup lang="ts">
import axios from 'axios';
import { ref, onMounted, onUnmounted, nextTick, watch } from 'vue'

// 从 localStorage 获取用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const hotItems = ref<any[]>([]);

// 创建响应式的 displayItems 用于显示
const displayItems = ref<any[]>([]);

axios.get('http://localhost:8080/game/get-recommendations', {
  params: {
    userId: user.userId
  }
})
  .then(response => {
    console.log(response.data);  // 查看推荐游戏数据
    const recommendedGames = response.data.recommended_games;
    console.log(recommendedGames);  // 输出游戏ID数组

    // 创建获取游戏详情的函数
    const getGameDetails = (gameId: number) => {
      return axios.get(`http://localhost:8080/game/details/${gameId}`)
        .then(response => {
          const game = response.data;
          console.log(response.data)
          return {
            gameName: game.data.gameName,          // 游戏名称
            mainImageUrl: game.data.gameId   // 游戏封面URL
          };
        })
        .catch(error => {
          console.error(`Error fetching game details for gameId ${gameId}:`, error);
          return null;  // 如果有错误，返回null
        });
    };

    // 批量请求所有游戏的详情
    const gameDetailsPromises = recommendedGames.map(gameId => getGameDetails(gameId));

    // 等待所有游戏详情返回
    Promise.all(gameDetailsPromises)
      .then(allGameDetails => {
        // 将获取到的游戏详情添加到 hotItems 中
        console.log(allGameDetails);
        hotItems.value = allGameDetails.filter(item => item !== null);
        console.log(hotItems.value);  // 输出包含名称和封面的游戏数据

      })
      .catch(error => {
        console.error('Error fetching all game details:', error);
      });

  })
  .catch(error => {
    console.error('Error fetching recommendations:', error);
  });

// 每当 hotItems 发生变化时，重新计算 displayItems
watch(hotItems, () => {
  // 克隆前 visibleCount 个元素，实现无缝滚动
  displayItems.value = [...hotItems.value, ...hotItems.value.slice(0, 6)];
});

const visibleCount = 6       // 一次显示 6 个
const itemWidth = 200        // 每个元素宽度
const transitionTime = 1000   // ms

// 克隆前 visibleCount 个元素，实现无缝滚动
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

// 备用图片路径
const defaultImage = '/gameimg/kemomimi.jpg';
// 处理图片加载失败时使用默认图片
const handleImageError = (event) => {
  event.target.src = defaultImage; // 替换为默认图片
}

</script>
<template>
  <div class="home-view">
    <span>我们跳票了</span>
    <br>
    <img src="/cyber.png" alt="Cyber" />
    <div>
      <span>根据您的喜好推荐：</span>
      <div class="like">
        <div class="like-track" :style="{
          transform: `translateX(-${currentIndex * itemWidth}px)`,
          transition: isTransitioning ? `transform ${transitionTime}ms ease-in-out` : 'none'
        }" @transitionend="handleTransitionEnd">
          <div class="like-item" v-for="(item, index) in displayItems" :key="index">
            <div class="game-cover">
              <img :src="`/gameimg/${item.mainImageUrl}.jpg`" alt="Game Cover" @error="handleImageError" />
              <!-- 游戏名称浮动在图片上方 -->
              <div class="game-name">{{ item.gameName }}</div>
            </div>
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

span{

}


.sol {
  width: 1200px;
  height: 400px;
  background-color: rgb(117, 117, 117);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  margin: auto;
}

.sol-image {
  flex: 0 0 400px;
  height: 380px;
  background-color: #f8cccc;
}

.sol-description {
  flex: 1;
  padding-left: 20px;
  font-size: 18px;
  color: #fff;
}

.home-view {
  padding-top: 40px;
  width: 1350px;
  height: auto;
  text-align: center;
  color: #fff;
  background-color: rgba(43, 43, 43, 0.745);
}

.like {
  width: 1200px;
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

.game-cover {
  position: relative;
  width: 100%;
  /* 容器宽度为父容器的100% */
  padding-top: 100%;
  /* 设置正方形高度（高度 = 宽度的100%） */
  height: 0;
  /* 高度由 padding-top 决定，保持正方形 */
  overflow: hidden;
  /* 隐藏超出容器的图片部分 */
}

.game-cover img {
  position: absolute;
  /* 使图片脱离文档流 */
  top: 50%;
  /* 上边距50%，确保图片垂直居中 */
  left: 50%;
  /* 左边距50%，确保图片水平居中 */
  transform: translate(-50%, -50%);
  /* 使用 transform 来确保图片完全居中 */
  width: 100%;
  /* 设置图片的宽度为容器的100% */
  height: 100%;
  /* 设置图片的高度为容器的100% */
  object-fit: cover;
  /* 保持图片的宽高比，裁剪多余部分填满容器 */
}

.game-name {
  position: absolute;
  /* 使其浮动在图片上面 */
  bottom: 0;
  left: 0;
  font-size: 16px;
  width: 100%;
  color: #fff;
  background-color: rgba(125, 125, 125, 0.5);
  /* 半透明背景 */
  padding: 5px;
  border-radius: 5px;
}
</style>
