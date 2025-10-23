<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import navigaton from '@/components/share/navigaton.vue'

const subTop = ref(60) // 初始 top 60px

const handleScroll = () => {
  const scrollY = window.scrollY
  // 当滚动超过 60px，就把 top 设置为 0
  subTop.value = scrollY >= 60 ? 0 : 60 - scrollY
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<template>
  <main>
    <div class="top"></div>

    <div class="main">
      <!-- 推荐区 -->
      <div class="game">
        <h2>推荐</h2>
        <div class="product-box">
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品A" />
            <p class="name">示例商品 A</p>
            <p class="price">￥99.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
        </div>
      </div>

      <!-- 今日特卖区 -->
      <div class="game">
        <h2>今日特卖</h2>
        <div class="product-box">
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品C" />
            <p class="name">特卖商品 C</p>
            <p class="price">￥59.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品D" />
            <p class="name">特卖商品 D</p>
            <p class="price">￥79.00</p>
          </div>
        </div>
      </div>

      <!-- 继续保留探索区 -->
      <div class="game">
        <h2>探索</h2>
        <div class="product-box">
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品A" />
            <p class="name">示例商品 A</p>
            <p class="price">￥99.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
          <div class="product-card">
            <img src="../assets/img/kobe.png" alt="商品B" />
            <p class="name">示例商品 B</p>
            <p class="price">￥129.00</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 右侧固定区 -->
    <div class="sub" :style="{ top: subTop + 'px' }">
      <div class="comm">
        <h3>热门社区</h3>
        <div class="community-box">
          <div class="community-card">
            <img src="../assets/img/kobe.png" alt="社区1" />
            <p>抽象tv</p>
          </div>
          <div class="community-card">
            <img src="../assets/img/kobe.png" alt="社区2" />
            <p>冲浪tv</p>
          </div>
          <div class="community-card">
            <img src="../assets/img/kobe.png" alt="社区3" />
            <p>神奈川冲浪里</p>
          </div>
        </div>
      </div>

      <div class="tieba">
        <h3>热门帖子</h3>
        <div class="post-box">
          <div class="post-card">
            <p class="title">豪士小面包</p>
            <p class="author">作者：古德莉莉安</p>
          </div>
          <div class="post-card">
            <p class="title">我狗被蛇咬</p>
            <p class="author">作者：张顺爬</p>
          </div>
          <div class="post-card">
            <p class="title">爷爷大象笑</p>
            <p class="author">作者：缝合怪</p>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<style>
html,
body {
  width: 100vw;
  margin: 0;
  padding: 0;
}

main {
  height: 100%;

  /* 或直接 height: 100%; */
  width: 100%;
  /* background-color: aquamarine; */
}

.main {
  /* background-color: aqua; */
  width: 1000px;
}

.game {
  /* background-color: deeppink; */
  height: 300px;
  margin: 10px;
}

.sub {
  background-color: rgb(141, 244, 39);
  top: 60px;
  position: fixed;
  right: 70px;
  width: 400px;
  height: 800px;
  z-index: 1;
}

.game h2 {
  margin: 10px;
  font-size: 20px;
  color: #fff;
}

.product-box {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  padding: 10px;
  background-color: darkgrey;
  border-radius: 8px;
}

.product-card {
  width: 120px;
  background: #fff;
  border-radius: 6px;
  text-align: center;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  padding: 8px;
}

.product-card img {
  width: 100%;
  height: auto;
  border-radius: 4px;
}

.product-card .name {
  margin: 6px 0 2px;
  font-size: 14px;
  color: #333;
}

.product-card .price {
  font-size: 14px;
  color: #e53935;
}

/* 右侧固定区整体样式 */
.sub {
  position: fixed;
  top: 60px;
  right: 70px;
  width: 320px;
  /* 稍微收窄一点更像侧栏 */
  padding: 16px;
  background-color: #f8f8f8;
  /* 浅色背景 */
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 1;
  font-family: 'Segoe UI', Arial, sans-serif;
}

/* 标题样式 */
.sub h3 {
  margin: 12px 0;
  font-size: 18px;
  color: #333;
  border-left: 4px solid #42b983;
  /* Vue 绿 */
  padding-left: 8px;
}

/* 社区卡片区域 */
.community-box {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-bottom: 20px;
}

.community-card {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #fff;
  padding: 8px 10px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
  cursor: pointer;
  transition: transform 0.2s ease;
}

.community-card:hover {
  transform: translateY(-2px);
}

.community-card img {
  width: 50px;
  height: 50px;
  border-radius: 8px;
  object-fit: cover;
}

.community-card p {
  margin: 0;
  font-size: 14px;
  color: #444;
}

/* 热门帖子区域 */
.post-box {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.post-card {
  background: #fff;
  padding: 8px 10px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
  cursor: pointer;
  transition: background 0.2s ease;
}

.post-card:hover {
  background: #f0f0f0;
}

.post-card .title {
  font-size: 14px;
  font-weight: 600;
  color: #333;
  margin: 0 0 4px;
}

.post-card .author {
  font-size: 12px;
  color: #777;
  margin: 0;
}

/* 推荐区整体放大 */
.game:first-of-type {
  /* 推荐区的外层 div */
  width: 100%;
  /* 让推荐区域更高 */
  min-height: 400px;
}

/* 推荐区产品盒子更宽 */
.game:first-of-type .product-box {
  gap: 20px; /* 卡片间距加大 */
  padding: 20px; /* 内边距更大 */
  background-color: #d0d0d0; /* 可以稍微调亮一点 */
}

/* 推荐区的商品卡片更大 */
.game:first-of-type .product-card {
  width: 180px; /* 原来 120px → 180px */
  padding: 12px;
  border-radius: 10px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.game:first-of-type .product-card img {
  width: 100%;
  height: auto;
  border-radius: 6px;
}

.game:first-of-type .product-card .name {
  margin: 10px 0 4px;
  font-size: 16px; /* 字体加大 */
  color: #333;
}

.game:first-of-type .product-card .price {
  font-size: 18px; /* 价格更醒目 */
  color: #e53935;
  font-weight: bold;
}

/* 探索区卡片每行单个，左右布局 */
.game:nth-of-type(3) .product-box {
  display: flex;
  flex-direction: column; /* 每行一个卡片 */
  gap: 12px;
  padding: 10px;
  background-color: #d8d8d8;
  border-radius: 8px;
}

.game:nth-of-type(3) .product-card {
  display: flex; /* 内部横向布局 */
  align-items: center; /* 图片与文字垂直居中 */
  gap: 12px; /* 图片和文字间距 */
  width: 100%; /* 占满容器宽度 */
  padding: 12px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  background-color: #fff;
}

/* 图片固定大小 */
.game:nth-of-type(3) .product-card img {
  width: 120px;
  height: 120px;
  object-fit: cover;
  border-radius: 8px;
}

/* 商品描述 */
.game:nth-of-type(3) .product-card .name,
.game:nth-of-type(3) .product-card .price {
  margin: 0;
}

.game:nth-of-type(3) .product-card .name {
  font-size: 16px;
  font-weight: bold;
  color: #333;
}

.game:nth-of-type(3) .product-card .price {
  font-size: 18px;
  color: #e53935;
  font-weight: bold;
}
</style>
