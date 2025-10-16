<template>
  <div class="library-page">
    <!-- 登录提示区域 -->
    <div v-if="!isLoggedIn" class="login-placeholder">
      <h2>请先登录查看您的游戏库</h2>
      <div class="placeholder-box">登录提示区域（预留位置）</div>
    </div>

    <!-- 加载中 -->
    <div v-else-if="loading" class="loading-container">
      <div class="spinner"></div>
      <p>加载中，请稍候...</p>
    </div>

    <!-- 游戏库 -->
    <div v-else class="library-container">
      <h2 class="library-title">我的游戏库</h2>

      <!-- 无数据提示 -->
      <div v-if="games.length === 0" class="no-data">
        暂无游戏，请前往商城购买～
      </div>

      <!-- 游戏卡片 -->
      <div class="game-grid">
        <div class="game-card" v-for="game in games" :key="game.gameId">
          <div class="game-image" @click="goToDetail(game.gameId)">
            <img :src="game.mainImageUrl" :alt="game.gameName" />
            <div class="overlay">点击查看详情</div>
          </div>

          <div class="game-info">
            <div class="game-name">{{ game.gameName }}</div>
            <div class="game-source">来源：{{ game.source }}</div>

            <div class="button-group">
              <button class="btn btn-detail" @click="goToDetail(game.gameId)">
                查看详情
              </button>
              <button class="btn btn-remove" @click="handleRemove(game.gameId)">
                移除
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { getMyLibrary, removeGame } from "../api/library.js";
import { useRouter } from "vue-router";

const router = useRouter();
const games = ref([]);
const loading = ref(false);
const isLoggedIn = ref(true); // TODO: 登录后可替换成 token 检测
const userId = 1; // TODO: 替换成真实登录用户 ID

// 加载游戏库
async function loadLibrary() {
  loading.value = true;
  try {
    const res = await getMyLibrary(userId);
    if (res.data.code === 200) {
      games.value = res.data.data;
    } else {
      console.warn(res.data.message);
    }
  } catch (err) {
    console.error("加载失败：", err);
  } finally {
    loading.value = false;
  }
}

// 移除游戏
async function handleRemove(gameId) {
  if (!confirm("确定要移除此游戏吗？")) return;
  try {
    const res = await removeGame(userId, gameId);
    if (res.data.code === 200) {
      games.value = games.value.filter((g) => g.gameId !== gameId);
      alert("已移除游戏");
    } else {
      alert("操作失败：" + res.data.message);
    }
  } catch (err) {
    console.error(err);
  }
}

// 跳转详情页
function goToDetail(gameId) {
  router.push(`/game/${gameId}`);
}

onMounted(() => {
  if (isLoggedIn.value) loadLibrary();
});
</script>

<style scoped>
/* 整体页面背景 */
.library-page {
  min-height: 100vh;
  background-color: #1b1b1b;
  color: #eaeaea;
  padding: 30px;
  font-family: "Microsoft YaHei", sans-serif;
}

/* 登录提示 */
.login-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 70vh;
  text-align: center;
}
.login-placeholder h2 {
  font-size: 24px;
  margin-bottom: 20px;
}
.placeholder-box {
  width: 240px;
  height: 240px;
  background-color: #2c2c2c;
  border-radius: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #777;
}

/* 加载中动画 */
.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 70vh;
}
.spinner {
  width: 50px;
  height: 50px;
  border: 4px solid #333;
  border-top-color: #3b82f6;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 10px;
}
@keyframes spin {
  100% {
    transform: rotate(360deg);
  }
}

/* 标题 */
.library-title {
  text-align: center;
  font-size: 28px;
  font-weight: bold;
  margin-bottom: 30px;
}

/* 无数据提示 */
.no-data {
  text-align: center;
  color: #888;
  margin-top: 60px;
}

/* 卡片网格布局 */
.game-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 25px;
}

/* 单个游戏卡片 */
.game-card {
  background-color: #2a2a2a;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  transition: transform 0.3s, box-shadow 0.3s;
}
.game-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(59, 130, 246, 0.3);
}

/* 图片部分 */
.game-image {
  position: relative;
  height: 140px;
  overflow: hidden;
  cursor: pointer;
}
.game-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s;
}
.game-image:hover img {
  transform: scale(1.05);
}
.overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  color: #eaeaea;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  font-size: 14px;
  transition: opacity 0.3s;
}
.game-image:hover .overlay {
  opacity: 1;
}

/* 游戏信息区 */
.game-info {
  padding: 15px;
}
.game-name {
  font-size: 16px;
  font-weight: 600;
  color: #fff;
  margin-bottom: 5px;
}
.game-source {
  font-size: 13px;
  color: #aaa;
  margin-bottom: 10px;
}

/* 按钮组 */
.button-group {
  display: flex;
  justify-content: space-between;
}
.btn {
  flex: 1;
  padding: 6px 10px;
  border: none;
  border-radius: 6px;
  color: #fff;
  font-size: 13px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.btn + .btn {
  margin-left: 8px;
}
.btn-detail {
  background-color: #3b82f6;
}
.btn-detail:hover {
  background-color: #2563eb;
}
.btn-remove {
  background-color: #e53935;
}
.btn-remove:hover {
  background-color: #c62828;
}

/* 滚动条样式 */
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-thumb {
  background-color: #444;
  border-radius: 4px;
}
::-webkit-scrollbar-thumb:hover {
  background-color: #666;
}
</style>
