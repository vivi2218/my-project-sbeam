<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const token = localStorage.getItem('sbeam_token')
const sbeam_user = localStorage.getItem('sbeam_user')
const userId= sbeam_user ? JSON.parse(sbeam_user).userId : ''

// ==================== 数据区 ====================
const loading = ref(false)
const order = reactive({
  orderId: '',
  orderNumber: '',
  finalPrice: '',
  orderStatus: '',
  orderCreateTime: ''
})
const cartItems = ref([])
const countdown = ref(900)
let timer = null
const isExpired = ref(false)

// 从localStorage获取订单信息
const getOrderFromStorage = () => {
  const storedOrder = localStorage.getItem('currentOrder')
  if (storedOrder) {
    return JSON.parse(storedOrder)
  }
  return null
}

// 保存订单信息到localStorage
const saveOrderToStorage = (orderData) => {
  localStorage.setItem('currentOrder', JSON.stringify(orderData))
}

// 计算剩余支付时间
const calculateRemainingTime = (createTime) => {
  try {
    // 确保createTime是有效的时间字符串
    const createDate = new Date(createTime);
    // 检查日期是否有效
    if (isNaN(createDate.getTime())) {
      console.error('无效的创建时间:', createTime);
      // 如果时间无效，返回默认的15分钟
      return 15 * 60;
    }
    
    const createTimestamp = createDate.getTime();
    const nowTimestamp = new Date().getTime();
    const totalDuration = 15 * 60 * 1000; // 15分钟
    const elapsedTime = nowTimestamp - createTimestamp;
    const remainingTime = Math.max(0, Math.floor((totalDuration - elapsedTime) / 1000));
    
    console.log('计算剩余时间:', {
      createTime,
      createTimestamp,
      nowTimestamp,
      elapsedTime,
      remainingTime
    });
    
    return remainingTime;
  } catch (error) {
    console.error('计算剩余时间出错:', error);
    // 出错时返回默认的15分钟
    return 15 * 60;
  }
}

// ==================== 幂等Token ====================
let formtoken = ''
let formvalue = ''

async function getIdempotentToken() {
  const res = await axios.get(`http://localhost:8080/idempotent/createToken?userId=${userId}`)
  if (res.data.code === 200) {
    formtoken = res.data.data.formtoken
    formvalue = res.data.data.formvalue
    console.log('✅ 获取幂等token成功:', formtoken, formvalue)
  } else {
    alert('❌ 获取幂等token失败')
  }
}

// ==================== 创建订单 ====================
async function createOrder() {
  try {
    loading.value = true
    // 先清除可能存在的旧订单信息，确保创建新订单
    localStorage.removeItem('currentOrder')

    const res = await axios.post(
      `http://localhost:8080/myorder/create`,
      {},
      {
        headers: {
          formtoken,
          formvalue,
          Authorization: token,
        },
      }
    )
    console.log('创建订单响应:', res)

    if (res.data.code === 200) {
        const data = res.data.data
        order.orderId = data.orderId
        order.orderNumber = data.orderNumber
        order.finalPrice = data.finalPrice
        order.orderStatus = data.orderStatus
        
        // 安全地设置订单创建时间
        try {
          // 检查后端返回的时间格式
          if (data.orderDate) {
            // 确保时间字符串格式正确
            const orderDateStr = String(data.orderDate);
            // 处理可能的LocalDateTime格式 (yyyy-MM-dd'T'HH:mm:ss.SSS)
            const standardizedDateStr = orderDateStr.replace('T', ' ').split('.')[0];
            order.orderCreateTime = new Date(standardizedDateStr).toISOString();
          } else {
            order.orderCreateTime = new Date().toISOString();
          }
        } catch (timeError) {
          console.error('时间格式处理错误:', timeError);
          order.orderCreateTime = new Date().toISOString(); // 出错时使用当前时间
        }
        
        console.log('✅ 创建订单成功:', order)

        // 保存订单信息到localStorage
        saveOrderToStorage(order)

        // 获取购物车内容用于展示
        const cartRes = await axios.get(`http://localhost:8080/cart`, {
          headers: { Authorization: token },
        })
        cartItems.value = cartRes.data || []

        // 计算剩余支付时间
        countdown.value = calculateRemainingTime(order.orderCreateTime)
        
        // 为新创建的订单，不应该立即判断超时，直接开启倒计时
        console.log('新订单初始倒计时:', countdown.value)
        startCountdown()
    } else if (res.data.code === 201) {
      // 201 表示库存不足等业务逻辑错误
      const errorMsg = res.data.data || '创建订单失败'
      console.error('❌ 创建订单失败:', errorMsg)
      // 清除可能存在的旧订单信息
      localStorage.removeItem('currentOrder')
      alert('❌ ' + errorMsg)
      throw new Error(errorMsg)
    } else {
      const errorMsg = res.data.message || '创建订单失败'
      console.error('❌ 创建订单失败:', errorMsg)
      // 清除可能存在的旧订单信息
      localStorage.removeItem('currentOrder')
      alert('❌ ' + errorMsg)
      throw new Error(errorMsg)
    }
  } catch (err) {
    console.error('❌ 创建订单出错:', err)
    // 无论何种错误，都清除旧订单信息
    localStorage.removeItem('currentOrder')
    if (!err.message.includes('创建订单失败')) {
      alert(err.message || '订单创建失败，请重试')
    }
  } finally {
    loading.value = false
  }
}

// ==================== 倒计时 ====================
function startCountdown() {
  timer = setInterval(() => {
    // 每次都重新计算剩余时间，确保准确性
    if (order.orderCreateTime) {
      countdown.value = calculateRemainingTime(order.orderCreateTime)
      
      if (countdown.value <= 0) {
        clearInterval(timer)
        isExpired.value = true
        // 清除localStorage中的订单信息
        localStorage.removeItem('currentOrder')
      }
    }
  }, 1000)
}
function formatTime(sec) {
  try {
    // 确保sec是有效的数字
    const seconds = Number(sec);
    if (isNaN(seconds)) {
      console.error('无效的秒数:', sec);
      return '15:00'; // 返回默认值
    }
    
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
  } catch (error) {
    console.error('格式化时间出错:', error);
    return '15:00'; // 出错时返回默认值
  }
}

// ==================== 调用支付宝支付 ====================
async function goPay() {
  if (isExpired.value) {
    alert('订单已超时，请重新下单')
    return
  }

  const myorder = {
    orderId: order.orderId,
    userId: userId,
    orderNumber: order.orderNumber,
    finalPrice: order.finalPrice,
    orderStatus: order.orderStatus,
  }

  try {
    const res = await axios.post('http://localhost:8080/paymentRecords', myorder, {
      headers: { 'Content-Type': 'application/json' },
    })
    // 返回HTML表单
    const div = document.createElement('div')
    div.innerHTML = res.data
    document.body.appendChild(div)
    document.forms[0].submit() // 自动跳转支付宝
  } catch (err) {
    console.error('❌ 发起支付失败:', err)
  }
}

// ==================== 验证订单有效性 ====================
async function validateOrder(orderNumber) {
  try {
    // 调用后端API验证订单是否有效
    const res = await axios.get(`http://localhost:8080/myorder/validate?orderNumber=${orderNumber}`, {
      headers: { Authorization: token },
    })
    return res.data.code === 200 && res.data.data === true
  } catch (error) {
    console.error('验证订单有效性失败:', error)
    return false
  }
}

// ==================== 初始化 ====================
onMounted(async () => {
  // 首先检查localStorage中是否有未完成的订单
  const storedOrder = getOrderFromStorage()
  
  if (storedOrder && storedOrder.orderCreateTime && storedOrder.orderNumber) {
    // 计算剩余支付时间
    countdown.value = calculateRemainingTime(storedOrder.orderCreateTime)
    
    // 检查是否已过期或订单是否有效
    if (countdown.value <= 0 || !(await validateOrder(storedOrder.orderNumber))) {
      // 订单已过期或无效，清除存储的订单信息
      isExpired.value = true
      localStorage.removeItem('currentOrder')
      // 创建新订单
      await getIdempotentToken()
      await createOrder()
    } else {
      // 恢复有效订单信息
      Object.assign(order, storedOrder)
      
      // 获取购物车内容用于展示
      const cartRes = await axios.get(`http://localhost:8080/cart`, {
        headers: { Authorization: token },
      })
      cartItems.value = cartRes.data || []
      
      // 启动倒计时
      startCountdown()
    }
  } else {
    // 没有存储的订单或信息不完整，创建新订单
    await getIdempotentToken()
    await createOrder()
  }
})
</script>

<template>
  <div class="confirm-order-page">
    <div class="order-card">
      <h2 class="title">🧾 确认订单</h2>

      <div v-if="order.orderNumber" class="order-info">
        <p><strong>订单号：</strong> {{ order.orderNumber }}</p>
        <p><strong>应付金额：</strong> <span class="price">{{ order.finalPrice }} 元</span></p>
        <p><strong>订单状态：</strong> {{ order.orderStatus }}</p>
        <p class="countdown">
          请在 <b>{{ formatTime(countdown) }}</b> 内完成支付，否则订单将自动取消。
        </p>
      </div>

      <div class="cart-box" v-if="cartItems.length > 0">
        <h3>🛒 商品列表</h3>
        <ul>
          <li v-for="item in cartItems" :key="item.cartId">
            <span>{{ item.gameName }}</span>
            <span class="price">   {{ item.gamePrice }} 元</span>
          </li>
        </ul>
      </div>

      <button
        @click="goPay"
        class="pay-btn"
        :disabled="isExpired || loading"
      >
        {{ loading ? '处理中...' : isExpired ? '已超时' : '去支付 💰' }}
      </button>
    </div>
  </div>
</template>

<style scoped>
.confirm-order {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding-top: 80px;
  background: linear-gradient(135deg, #7b2ff7, #f107a3);
}

.confirm-order-card {
  width: 80%; /* ✅ 改为占页面 80% 宽度 */
  max-width: 900px; /* ✅ 设置最大宽度，避免超大屏太宽 */
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  padding: 32px;
  animation: fadeIn 0.5s ease;
}

.title {
  font-size: 1.8rem;
  font-weight: bold;
  color: #a08dcd;
  text-align: center;
  margin-bottom: 20px;
}

.order-info {
  background-color: #b7a8d8;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 24px;
}

.order-info p {
  margin: 8px 0;
  font-size: 1.1rem;
  color: #444;
}

.order-info .price {
  color: #ff6a00;
  font-weight: bold;
  font-size: 1.2rem;
}

.games {
  border-top: 1px solid #eee;
  padding-top: 16px;
}

.games h3 {
  font-size: 1.3rem;
  margin-bottom: 12px;
}

.games ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.games li {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
  border-bottom: 1px dashed #ddd;
  color: #555;
  font-size: 1rem;
}

.pay-btn {
  display: block;
  width: 100%;
  padding: 14px 0;
  background: linear-gradient(90deg, #ff7a18, #af002d 85%);
  border: none;
  border-radius: 8px;
  color: white;
  font-size: 1.2rem;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: 16px;
}

.pay-btn:hover {
  transform: scale(1.03);
  box-shadow: 0 4px 12px rgba(255, 122, 24, 0.3);
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>


