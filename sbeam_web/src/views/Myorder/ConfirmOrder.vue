<script setup>
import { ref, onMounted, reactive } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const route = useRoute()

// 用户ID
const userId = route.query.userId || 1
const token = localStorage.getItem('sbeam_token')

// 倒计时
const countdown = ref(900)
const countdownTimer = ref(null)
const isPaymentDisabled = ref(false)
const isExpired = ref(false)

// 订单信息
const order = reactive({
  orderNumber: '',
  originalPrice: 0,
  finalPrice: 0,
  orderStatus: 'unpaid'
})

// 购物车商品
const items = ref([])

// === 获取购物车和订单信息 ===
const getOrderData = async () => {
  try {
    // 获取购物车
    const cartRes = await axios.get('http://localhost:8080/cart', {
      headers: { Authorization: token },
    })
    items.value = cartRes.data || []

    // 获取未支付订单
    const orderRes = await axios.get(`http://localhost:8080/myorder/user/${userId}/status/unpaid`)
    if (orderRes.data && orderRes.data.length > 0) {
      const o = orderRes.data[0]
      order.orderNumber = o.orderNumber
      order.originalPrice = o.originalPrice
      order.finalPrice = o.finalPrice
      order.orderStatus = o.orderStatus
    } else {
      console.log('当前无未支付订单')
    }
  } catch (error) {
    console.error('获取订单数据失败:', error)
  }
}

// === 倒计时逻辑 ===
const startCountdown = () => {
  countdownTimer.value = setInterval(() => {
    if (countdown.value > 0) countdown.value--
    else {
      clearInterval(countdownTimer.value)
      isExpired.value = true
      isPaymentDisabled.value = true
    }
  }, 1000)
}

// 格式化倒计时
const formatCountdown = (seconds) => {
  const min = Math.floor(seconds / 60)
  const sec = seconds % 60
  return `${String(min).padStart(2, '0')}:${String(sec).padStart(2, '0')}`
}

// === 发起支付（调用后端 /alipay 接口） ===
const handlePayment = async () => {
  if (isExpired.value) return alert('订单已过期，请重新下单')

  try {
    // 构造 Myorder 对象
    const myorder = {
      orderId: order.orderId,
      userId: userId,
      orderNumber: order.orderNumber,
      originalPrice: order.originalPrice,
      finalPrice: order.finalPrice,
      orderStatus: order.orderStatus
    }

    // 向后端发送请求，获取支付宝支付表单
    const res = await axios.post('http://localhost:8080/alipay', myorder, {
      headers: { 'Content-Type': 'application/json' }
    })

    // res.data 是 HTML 表单字符串，将其插入 DOM 并自动提交
    const div = document.createElement('div')
    div.innerHTML = res.data
    document.body.appendChild(div)
    document.forms[0].submit() // 自动跳转支付宝

  } catch (err) {
    console.error('发起支付失败:', err)
  }
}

// === 页面初始化 ===
onMounted(() => {
  getOrderData()
  startCountdown()
})
</script>

<template>
  <div class="order-confirm">
    <h1 class="title">确认订单</h1>

    <div class="order-details">
      <p><strong>订单号:</strong> {{ order.orderNumber || '未生成' }}</p>
      <p><strong>原价:</strong> {{ order.originalPrice }} 元</p>
      <p><strong>应付总价:</strong> <span class="price">{{ order.finalPrice }} 元</span></p>

      <p><strong>商品列表:</strong></p>
      <ul class="items-list">
        <li v-for="item in items" :key="item.gameId" class="item">
          <span class="game-name">{{ item.gameName }}</span>
          <span class="game-price">{{ item.gamePrice }} 元</span>
        </li>
      </ul>
    </div>

    <div class="payment-info">
      <p>请在 <span class="countdown">{{ formatCountdown(countdown) }}</span> 内完成支付</p>
      <button @click="handlePayment" :disabled="isPaymentDisabled" class="payment-button">
        去 支 付
      </button>
    </div>

    <div v-if="isExpired" class="expired-message">
      <p>订单已过期，请重新下单。</p>
    </div>
  </div>
</template>

<style scoped>
.order-confirm {
  width: 800px;
  margin: 50px auto;
  padding: 30px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}
.title {
  text-align: center;
  font-size: 1.8rem;
  color: #333;
  margin-bottom: 20px;
}
.order-details {
  background: #fafafa;
  padding: 15px;
  border-radius: 8px;
  border: 1px solid #eaeaea;
  margin-bottom: 20px;
}
.items-list {
  list-style: none;
  padding: 0;
}
.item {
  display: flex;
  justify-content: space-between;
  border-bottom: 1px solid #eaeaea;
  padding: 10px 0;
}
.price {
  color: #f39c12;
  font-weight: bold;
}
.payment-info {
  text-align: center;
  margin-top: 20px;
}
.countdown {
  color: #e74c3c;
  font-weight: bold;
  background-color: rgba(231, 76, 60, 0.1);
  padding: 5px 10px;
  border-radius: 5px;
}
.payment-button {
  width: 100%;
  padding: 12px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 5px;
  margin-top: 15px;
  cursor: pointer;
}
.payment-button:hover {
  background-color: #45a049;
}
.payment-button:disabled {
  background-color: #ccc;
}
.expired-message {
  margin-top: 20px;
  text-align: center;
  color: #e74c3c;
  font-weight: bold;
}
</style>
