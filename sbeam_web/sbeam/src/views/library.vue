<template>
  <div class="library-page">
    <h1 class="page-title">我的游戏库</h1>

    <!-- 登录提示 -->
    <div v-if="!isLoggedIn" class="login-hint">
      <p>请先登录以查看您的游戏库。</p>
      <button class="login-btn">立即登录</button>
    </div>

    <!-- 游戏列表 -->
    <div v-else class="game-list">
      <div
        v-for="game in gameList"
        :key="game.id"
        class="game-card"
      >
        <img :src="game.cover" alt="封面" class="game-cover" />
        <div class="game-info">
          <h2>{{ game.name }}</h2>
          <p class="playtime">已游玩：{{ game.playTime }} 小时</p>
          <p class="category">类别：{{ game.category }}</p>
          <p class="purchased-date">购买时间：{{ game.purchasedAt }}</p>

          <div class="actions">
            <button class="play-btn">开始游戏</button>
            <button class="detail-btn">查看详情</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 没有游戏 -->
    <div v-if="isLoggedIn && gameList.length === 0" class="empty-hint">
      <p>您还没有购买任何游戏。</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue"

// 模拟用户是否登录
const isLoggedIn = ref(true) // 先默认已登录，可改成 false 测试

// 模拟已购买游戏（死数据）
const gameList = ref([
  {
    id: 1,
    name: "赛博朋克 2077",
    cover: "https://cdn.cloudflare.steamstatic.com/steam/apps/1091500/header.jpg",
    category: "动作 / 冒险 / RPG",
    playTime: 24,
    purchasedAt: "2025-08-12",
  },
  {
    id: 2,
    name: "只狼：影逝二度",
    cover: "https://cdn.cloudflare.steamstatic.com/steam/apps/814380/header.jpg",
    category: "动作 / 武士 / 冒险",
    playTime: 37,
    purchasedAt: "2025-07-03",
  },
  {
    id: 3,
    name: "霍格沃茨之遗",
    cover: "https://cdn.cloudflare.steamstatic.com/steam/apps/990080/header.jpg",
    category: "魔法 / 冒险 / 开放世界",
    playTime: 15,
    purchasedAt: "2025-09-10",
  },
])
</script>

<style scoped>
.library-page {
  background-color: #121212;
  color: #fff;
  min-height: 100vh;
  padding: 30px;
}

.page-title {
  font-size: 2.2em;
  font-weight: bold;
  margin-bottom: 20px;
  color: #00b3ff;
}

/* 登录提示 */
.login-hint {
  background: #1e1e1e;
  border-radius: 10px;
  padding: 40px;
  text-align: center;
  color: #ccc;
}

.login-btn {
  margin-top: 20px;
  padding: 10px 18px;
  border: none;
  border-radius: 6px;
  background-color: #00b3ff;
  color: white;
  font-weight: bold;
  cursor: pointer;
  transition: 0.3s;
}

.login-btn:hover {
  background-color: #0090cc;
}

/* 游戏列表 */
.game-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.game-card {
  background: #1c1c1c;
  border-radius: 12px;
  overflow: hidden;
  width: 360px;
  display: flex;
  transition: 0.3s;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

.game-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 0 15px rgba(0, 179, 255, 0.3);
}

.game-cover {
  width: 130px;
  height: 180px;
  object-fit: cover;
}

.game-info {
  padding: 10px 14px;
  flex: 1;
}

.game-info h2 {
  font-size: 1.1em;
  color: #fff;
  margin-bottom: 8px;
}

.playtime,
.category,
.purchased-date {
  font-size: 13px;
  color: #aaa;
  margin-bottom: 6px;
}

.actions {
  margin-top: 10px;
  display: flex;
  gap: 10px;
}

.play-btn,
.detail-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 6px;
  font-size: 13px;
  cursor: pointer;
  transition: 0.3s;
}

.play-btn {
  background-color: #00b3ff;
  color: white;
}

.play-btn:hover {
  background-color: #0090cc;
}

.detail-btn {
  background-color: #333;
  color: #ccc;
}

.detail-btn:hover {
  background-color: #444;
  color: #fff;
}

/* 空状态提示 */
.empty-hint {
  text-align: center;
  margin-top: 40px;
  color: #888;
  font-size: 15px;
}
</style>
