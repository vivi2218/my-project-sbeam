<template>
  <div class="order-page">
    <div class="orderStyle">


    <!-- 订单列表 -->
    <div class="order-list">
      <!-- 单个订单 -->
      <div class="order-card">
        <div class="order-header">
          <span class="order-id">订单号: #20250922001</span>
          <span class="order-status status-paid">已支付</span>
        </div>
        <div class="order-body">
          <img class="game-cover" src="https://via.placeholder.com/80x100" alt="Game Cover" />
          <div class="game-info">
            <h3 class="game-title">塞尔达传说：旷野之息</h3>
            <p class="game-price">￥299.00</p>
            <p class="game-time">下单时间：2025-09-20</p>
          </div>
        </div>
        <div class="order-footer">
          <button class="btn btn-detail">查看详情</button>
          <button class="btn btn-download">下载游戏</button>
        </div>
      </div>

      <!-- 示例订单 -->
      <div class="order-card">
        <div class="order-header">
          <span class="order-id">订单号: #20250922002</span>
          <span class="order-status status-unpaid">待支付</span>
        </div>
        <div class="order-body">
          <img class="game-cover" src="https://via.placeholder.com/80x100" alt="Game Cover" />
          <div class="game-info">
            <h3 class="game-title">艾尔登法环</h3>
            <p class="game-price">￥399.00</p>
            <p class="game-time">下单时间：2025-09-21</p>
          </div>
        </div>
        <div class="order-footer">
          <button class="btn btn-pay">立即支付</button>
          <button class="btn btn-cancel">取消订单</button>
        </div>
      </div>
    </div>
    </div>
  </div>
</template>

<style scoped>
/* ========== 基础样式 ========== */
body {
  overflow-x: hidden;
  background-color: rgb(14, 16, 14); /* 保证背景统一 */
}

.orderStyle {
  width: 100vw;         /* 容器宽度 */
  max-width: 1600px;   /* 可以加个最大宽度，让大屏不至于太宽 */
  margin: 0 auto;      /* 👈 关键：居中 */
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #212121;
  box-sizing: border-box;
  overflow-y: auto;
  font-family: 'Microsoft Yahei', sans-serif;
  color: #f5f5f5;
}


.title {
  text-align: center;
  margin-bottom: 20px;
  color: #fff;
}

.order-list {

  display: flex;
  flex-direction: column;
  gap: 20px;
  flex: 1; /* 撑开剩余空间 */
}

.order-card {
  background: #2a2a2a;
  border-radius: 12px;
  padding: 15px;
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    transition: all 0.3s ease; /* 添加过渡效果 */
}
.order-card:hover {
  border: 6px solid #076f1d;  /* 加粗描边 */
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2); /* 更柔和的阴影效果 */
}

.order-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  font-size: 14px;
}

.order-status {
  font-weight: bold;
  padding: 2px 8px;
  border-radius: 6px;
}

.status-unpaid {
  background-color: #ffc107;
  color: #333;
}

.order-body {
  display: flex;
  align-items: center;
  gap: 15px;
}

.game-cover {
  width: 80px;
  height: 100px;
  border-radius: 8px;
  object-fit: cover;
}

.game-info {
  flex: 1;
}

.game-title {
  margin: 0;
  font-size: 18px;
  font-weight: bold;
}

.game-time {
  font-size: 13px;
  color: #aaa;
}

.order-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 10px;
}

.btn {
  padding: 6px 12px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
}

.btn-detail {
  background-color: #007bff;
  color: #fff;
}

.btn-pay {
  background-color: #ffc107;
  color: #333;
}

.btn-cancel {
  background-color: #dc3545;
  color: #fff;
}
</style>
