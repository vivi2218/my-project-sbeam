<template>
  <div class="payment-result">
    <div v-if="paymentStatus === 'success'" class="success">
      <h1>支付成功</h1>
      <p>感谢您的购买！</p>
      <!-- <p>订单号：<span class="order-number">{{ orderNumber }}</span></p>
      <p>支付金额：<span class="amount">{{ amount }} 元</span></p> -->
      <p>我们已经收到您的支付，订单正在处理中。</p>
      <button @click="viewOrderDetails" class="action-button">查看订单详情</button>
      <!-- <button @click="viewPaymentHistory" class="action-button secondary">查看我的支付记录</button> -->
    </div>

    <div v-else-if="paymentStatus === 'failure'" class="failure">
      <h1>支付失败</h1>
      <p>抱歉，支付未能成功。请检查您的支付信息或重新尝试。</p>
      <button @click="retryPayment" class="action-button">重新支付</button>
    </div>

    <div v-else class="loading">
      <h1>支付处理中...</h1>
      <p>正在确认支付状态，请稍候。</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

// 订单信息
const orderNumber = ref(null);  // 订单号
const amount = ref(null);       // 支付金额

// 支付状态：loading, success, failure
const paymentStatus = ref('success');

// 定时器，用于模拟支付状态查询
let timer = null;

// 从 URL 中获取订单号和支付金额
const urlParams = new URLSearchParams(window.location.search);
orderNumber.value = urlParams.get('orderId');
amount.value = urlParams.get('amount');

// 检查支付状态（模拟请求后端接口）
const checkPaymentStatus = () => {
  setTimeout(() => {
    const status = getPaymentStatusFromBackend(); // 模拟后端返回的状态
    if (status === 'success') {
      paymentStatus.value = 'success';
    } else {
      paymentStatus.value = 'failure';
    }
  }, 3000); // 假设支付状态更新的延时
};

// 模拟从后端获取支付状态
const getPaymentStatusFromBackend = () => {
  const randomStatus = 'success'; //Math.random() > 0.5 ? 'success' : 'failure';
  return randomStatus;
};

// 查看订单详情
const viewOrderDetails = () => {
  axios.get;
};

// 查看支付记录
const viewPaymentHistory = () => {
  window.location.href = '/payment-history';
};

// 重新支付
const retryPayment = () => {
  window.location.href = `/pay/${orderNumber.value}`;
};

// 在页面挂载时开始检查支付状态
onMounted(() => {
  checkPaymentStatus();
});

// 清理定时器（如果有的话）
onBeforeUnmount(() => {
  clearTimeout(timer);
});
</script>

<style scoped>
.payment-result {
  width: 80%;
  max-width: 400px;
  margin: 50px auto;
  padding: 30px;
  border-radius: 8px;
  text-align: center;
  background-color: #ffffff;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

h1 {
  font-size: 1.8rem;
  margin-bottom: 15px;
}

.order-number,
.amount {
  font-weight: bold;
  color: #333;
}

.success {
  color: #4CAF50;
}

.failure {
  color: #e74c3c;
}

.loading {
  color: #f39c12;
}

button {
  width: 100%;
  padding: 12px;
  background-color: #4CAF50;
  color: white;
  font-size: 1.2rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-top: 15px;
}

button:hover {
  background-color: #45a049;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.secondary {
  background-color: #3498db;
}

.secondary:hover {
  background-color: #2980b9;
}
</style>
