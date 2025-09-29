<template>
  <div class="game-detail-page">
    <!-- 游戏主信息 -->
    <div class="game-header">
      <img class="cover" :src="game.cover" alt="游戏封面" />
      <div class="info">
        <h1>{{ game.name }}</h1>
        <p class="intro">{{ game.description }}</p>
        <p>开发商：{{ game.developer }}</p>
        <p>发布日期：{{ game.releaseDate }}</p>
        <p class="rating">评分：{{ game.rating }}</p>

        <button class="buy-btn">立即购买 ￥{{ game.price }}</button>
      </div>
    </div>

    <!-- 游戏截图和视频 -->
    <div class="media-section">
      <h2>游戏截图</h2>
      <div class="screenshots">
        <img v-for="img in game.screenshots" :src="img" :key="img" />
      </div>
      <h2>游戏视频</h2>
      <video class="trailer" controls :src="game.trailer"></video>
    </div>

    <!-- 捆绑包模块 -->
    <div class="bundle-section" v-if="bundles.length">
      <h2>捆绑包优惠</h2>
      <div v-for="bundle in bundles" :key="bundle.id" class="bundle-card">
        <h3>{{ bundle.name }}</h3>
        <div class="bundle-games">
          <div v-for="g in bundle.games" :key="g.id" class="bundle-game">
            <img :src="g.cover" alt="子游戏" />
            <p>{{ g.name }}</p>
            <span class="price">￥{{ g.price }}</span>
          </div>
        </div>

        <div class="bundle-price">
          <p>原价合计：<span class="old">￥{{ bundle.totalPrice }}</span></p>
          <p>优惠价：<span class="new">￥{{ bundle.discountPrice }}</span></p>
          <button class="buy-bundle-btn">购买捆绑包</button>
        </div>
      </div>
    </div>

    <!-- 评论区 -->
    <div class="comment-section">
      <h2>玩家评论</h2>
      <div v-for="c in comments" :key="c.id" class="comment-card">
        <p class="author">{{ c.user }}</p>
        <p class="text">{{ c.content }}</p>
        <p class="score">评分：{{ c.score }}</p>
      </div>
    </div>

    <!-- 推荐区 -->
    <div class="recommend-section">
      <h2>相关推荐</h2>
      <div class="recommend-list">
        <div v-for="g in recommendGames" :key="g.id" class="recommend-card">
          <img :src="g.cover" alt="推荐游戏" />
          <h4>{{ g.name }}</h4>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const game = ref({
  id: 1,
  name: "暗影突袭",
  developer: "未来工作室",
  releaseDate: "2024-05-10",
  rating: 9.2,
  price: 99,
  description:
    "《暗影突袭》是一款充满动作与策略的冒险游戏，你将化身特种战士，潜入敌方基地，完成危险任务。",
  cover: "https://picsum.photos/400/250?random=10",
  screenshots: [
    "https://picsum.photos/300/200?random=11",
    "https://picsum.photos/300/200?random=12",
    "https://picsum.photos/300/200?random=13",
  ],
  trailer:
    "https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4",
});

// 捆绑包数据（假数据）
const bundles = ref([
  {
    id: 101,
    name: "暗影突袭合集包",
    totalPrice: 267,
    discountPrice: 199,
    games: [
      { id: 1, name: "暗影突袭", price: 99, cover: "https://picsum.photos/100/120?random=31" },
      { id: 2, name: "秘境探险", price: 79, cover: "https://picsum.photos/100/120?random=32" },
      { id: 3, name: "银河战士", price: 89, cover: "https://picsum.photos/100/120?random=33" },
    ],
  },
]);

const comments = ref([
  { id: 1, user: "玩家A", content: "画面精美，操作顺滑！", score: 9 },
  { id: 2, user: "玩家B", content: "剧情紧凑但略短，希望出续作。", score: 8 },
  { id: 3, user: "玩家C", content: "物超所值，非常推荐！", score: 10 },
]);

const recommendGames = ref([
  { id: 2, name: "秘境探险", cover: "https://picsum.photos/150/200?random=21" },
  { id: 3, name: "王国之心", cover: "https://picsum.photos/150/200?random=22" },
  { id: 4, name: "银河战士", cover: "https://picsum.photos/150/200?random=23" },
]);
</script>

<style scoped>
.game-detail-page {
  background-color: #121212;
  color: #e0e0e0;
  min-height: 100vh;
  padding: 30px;
  font-family: "Microsoft YaHei", sans-serif;
}

/* 顶部信息 */
.game-header {
  display: flex;
  gap: 30px;
  margin-bottom: 30px;
}
.cover {
  width: 400px;
  height: 250px;
  object-fit: cover;
  border-radius: 10px;
}
.info {
  flex: 1;
}
.intro {
  color: #aaa;
  margin: 10px 0;
  line-height: 1.6;
}
.rating {
  color: #66cc66;
  font-weight: bold;
}
.buy-btn {
  background: linear-gradient(45deg, #00b894, #0984e3);
  border: none;
  padding: 10px 20px;
  color: white;
  font-weight: bold;
  border-radius: 8px;
  cursor: pointer;
  transition: 0.3s;
}
.buy-btn:hover {
  transform: scale(1.05);
}

/* 媒体区 */
.media-section {
  margin-top: 40px;
}
.media-section h2 {
  margin-bottom: 10px;
}
.screenshots {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}
.screenshots img {
  width: 300px;
  height: 200px;
  object-fit: cover;
  border-radius: 8px;
}
.trailer {
  width: 80%;
  border-radius: 10px;
}

/* 捆绑包 */
.bundle-section {
  margin-top: 50px;
}
.bundle-card {
  background: #1c1c1c;
  padding: 20px;
  border-radius: 10px;
  margin-bottom: 20px;
}
.bundle-card h3 {
  margin-bottom: 10px;
}
.bundle-games {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;
}
.bundle-game {
  background: #2a2a2a;
  padding: 10px;
  border-radius: 6px;
  text-align: center;
  width: 120px;
}
.bundle-game img {
  width: 100px;
  height: 120px;
  object-fit: cover;
  border-radius: 6px;
}
.bundle-game .price {
  display: block;
  color: #ffcc66;
  margin-top: 5px;
}
.bundle-price {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.bundle-price .old {
  text-decoration: line-through;
  color: #888;
}
.bundle-price .new {
  color: #00b894;
  font-weight: bold;
}
.buy-bundle-btn {
  background: linear-gradient(45deg, #6c5ce7, #0984e3);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  cursor: pointer;
}
.buy-bundle-btn:hover {
  transform: scale(1.05);
}

/* 评论区 */
.comment-section {
  margin-top: 50px;
}
.comment-card {
  background: #1e1e1e;
  padding: 15px;
  margin-top: 10px;
  border-radius: 8px;
}
.comment-card .author {
  font-weight: bold;
}
.comment-card .score {
  color: #ffcc66;
}

/* 推荐区 */
.recommend-section {
  margin-top: 50px;
}
.recommend-list {
  display: flex;
  gap: 20px;
  margin-top: 15px;
}
.recommend-card {
  background: #1c1c1c;
  padding: 10px;
  border-radius: 8px;
  width: 150px;
  text-align: center;
}
.recommend-card img {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 6px;
}
</style>
