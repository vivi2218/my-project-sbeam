<script setup>
import { ref, onMounted, reactive } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';

const router = useRouter();
const route = useRoute();

// 获取路由中的 userId 和 finalPrice
const userId = route.query.userId;
const finalPrice = ref(0);
const countdown = ref(900); // 初始化倒计时为 15 分钟 (900 秒)
const countdownTimer = ref(null);
const isPaymentDisabled = ref(false);  // 控制支付按钮是否可点击
const isExpired = ref(false);  // 控制是否显示过期信息
const paymentStatus = ref('success'); // 支付状态

// 订单和购物车数据
const order = reactive({
  orderNumber: "ORD20210101",
  originalPrice: 500,
  finalPrice: 200,
  orderStatus: "unpaid",
});
const items = ref([game1={gameId: 1,gameName: "游戏A",gamePrice: 100},
                  game2={gameId: 2,gameName: "游戏B",gamePrice: 150}
                  ]);


// 查询购物车和订单信息
const getOrderData = async () => {
  try {
    // 获取购物车数据
    const cartResponse = await axios.get(`/api/cart/${userId}`);
    items.value = cartResponse.data.items;


    // 获取未支付订单信息
    const orderResponse = await axios.get(`/api/orders`, {
      params: { userId, status: 'unpaid' }
    });
    console.log('未支付订单响应:', orderResponse);
    if (orderResponse.data && orderResponse.data.length > 0) {
      order.orderNumber = orderResponse.data[0].orderNumber;
      order.originalPrice = orderResponse.data[0].originalPrice;
      order.finalPrice = orderResponse.data[0].finalPrice;
      order.orderStatus = orderResponse.data[0].orderStatus;
    } else {
      console.log('没有未支付的订单');
    }
  } catch (error) {
    console.error('获取数据失败:', error);
  }
};

// 开始倒计时（秒级倒计时）
const startCountdown = () => {
  countdownTimer.value = setInterval(() => {
    if (countdown.value > 0) {
      countdown.value--;
    } else {
      isExpired.value = true;
      isPaymentDisabled.value = true;
      clearInterval(countdownTimer.value); // 停止倒计时
    }
  }, 1000); // 每秒更新一次
};

// 格式化倒计时（转换为 "XX:XX" 格式）
const formatCountdown = (seconds) => {
  const minutes = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${String(minutes).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
};

// 支付处理
const handlePayment = () => {
  // 跳转到支付成功页面，模拟支付成功

  router.push({ path: '/paysuccess' });
  saveNewPayment();
};
  async function saveNewPayment(myorder){
    const res  = await savePayment(myorder)
     console.log(res)
     const div = document.createElement('div')

    div.innerHTML = res.data
    document.body.appendChild(div)
    document.forms[0].submit()  // 自动提交表单，跳转支付宝
   }

onMounted(() => {
  startCountdown();
  getOrderData(); // 获取购物车和订单数据
});
</script>
<template>
  <div class="order-confirm">
    <h1 class="title">确认订单</h1>
    <div class="order-details">
      <p><strong>订单号:</strong> {{ order.orderNumber || '无订单号' }}</p>
      <p><strong>总价:</strong> <span class="price">{{ order.totalPrice }} 元</span></p>
      <p><strong>商品:</strong></p>
      <ul class="items-list">
        <li v-for="item in order.items" :key="item.gameId" class="item">
          <span class="game-name">{{ item.gameName }}</span>
          <span class="game-price">{{ item.gamePrice }} 元</span>
        </li>
      </ul>
    </div>

    <div class="payment-info">
      <p>请在 <span class="countdown">{{ formatCountdown(countdown) }}</span> 内完成支付</p>
      <button @click="handlePayment" :disabled="isPaymentDisabled" class="payment-button">立即支付</button>
    </div>

    <div v-if="isExpired" class="expired-message">
      <p>订单已过期，请重新提交订单。</p>
    </div>
  </div>
</template>

<style scoped>
/* 主容器样式 */
.order-confirm {
  width: 800px; /* 减少宽度，使其看起来更紧凑 */
  margin: 50px auto;
  padding: 30px;
  background: #ffffff;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05); /* 更轻微的阴影 */
  border-radius: 8px;
  font-family: 'Helvetica Neue', Arial, sans-serif; /* 更现代的字体 */
  border: 1px solid #f0f0f0; /* 增加边框更简洁 */
}

/* 标题样式 */
.title {
  text-align: center;
  font-size: 1.8rem; /* 适当减小字体 */
  color: #333;
  margin-bottom: 20px;
}

/* 订单详情样式 */
.order-details {
  background: #fafafa; /* 轻微的背景色 */
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 20px;
  border: 1px solid #eaeaea; /* 更简洁的边框 */
}

.order-details p {
  font-size: 1rem;
  color: #555;
  margin-bottom: 10px;
}

.price {
  font-size: 1.2rem;
  color: #f39c12;
}

/* 商品列表样式 */
.items-list {
  list-style: none;
  padding: 0;
}

.item {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
  border-bottom: 1px solid #eaeaea;
}

.game-name {
  font-weight: bold;
}

.game-price {
  color: #f39c12;
}

/* 倒计时样式 */
.countdown {
  font-weight: bold;
  color: #e74c3c;
  font-size: 1.8rem; /* 较小的倒计时字体 */
  letter-spacing: 1px;
  padding: 3px 10px;
  background-color: rgba(231, 76, 60, 0.1);
  border-radius: 5px;
  display: inline-block;
  margin-top: 10px;
}

/* 支付信息部分 */
.payment-info {
  text-align: center;
  margin-top: 20px;
}

.payment-button {
  width: 100%;
  padding: 12px;
  background-color: #4CAF50;
  color: white;
  font-size: 1rem; /* 减小按钮文字大小 */
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-top: 15px;
}

.payment-button:hover {
  background-color: #45a049;
}

.payment-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

/* 过期信息 */
.expired-message {
  margin-top: 20px;
  color: #e74c3c;
  font-weight: bold;
  font-size: 1.2rem;
  text-align: center;
}

</style>
