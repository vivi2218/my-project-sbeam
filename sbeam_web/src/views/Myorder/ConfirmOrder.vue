<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const userId = route.query.userId || 1
const token = localStorage.getItem('sbeam_token')

// ==================== 数据区 ====================
const loading = ref(false)
const order = reactive({
  orderId: '',
  orderNumber: '',
  finalPrice: '',
  orderStatus: ''
})
const cartItems = ref([])
const countdown = ref(900)
let timer = null
const isExpired = ref(false)

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
      console.log('✅ 创建订单成功:', order)

      // 获取购物车内容用于展示
      const cartRes = await axios.get(`http://localhost:8080/cart`, {
        headers: { Authorization: token },
      })
      cartItems.value = cartRes.data || []


      // 开启倒计时
      startCountdown()
    } else if (res.data.code === 201) {
      // 201 表示库存不足等业务逻辑错误
      const errorMsg = res.data.data || '创建订单失败'
      console.error('❌ 创建订单失败:', errorMsg)
      alert('❌ ' + errorMsg)
      throw new Error(errorMsg)
    } else {
      const errorMsg = res.data.message || '创建订单失败'
      console.error('❌ 创建订单失败:', errorMsg)
      alert('❌ ' + errorMsg)
      throw new Error(errorMsg)
    }
  } catch (err) {
    console.error('❌ 创建订单出错:', err)
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
    if (countdown.value > 0) countdown.value--
    else {
      clearInterval(timer)
      isExpired.value = true
    }
  }, 1000)
}
function formatTime(sec) {
  const m = Math.floor(sec / 60)
  const s = sec % 60
  return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`
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

// ==================== 初始化 ====================
onMounted(async () => {
  await getIdempotentToken()
  await createOrder()
})
</script>

<template>
  <div class="confirm-order">
    <h2>确认订单</h2>

    <div v-if="order.orderNumber" class="order-box">
      <p><strong>订单号：</strong> {{ order.orderNumber }}</p>
      <p><strong>应付金额：</strong> <span class="price">{{ order.finalPrice }} 元</span></p>
      <p><strong>订单状态：</strong> {{ order.orderStatus }}</p>
      <p>请在 <b>{{ formatTime(countdown) }}</b> 内完成支付，否则订单将自动取消。</p>
    </div>

    <div class="cart-preview" v-if="cartItems.length > 0">
      <h3>商品列表：</h3>
      <ul>
        <li v-for="item in cartItems" :key="item.cartId">
          {{ item.gameName }} - {{ item.gamePrice }} 元
        </li>
      </ul>
    </div>

    <button
      @click="goPay"
      class="pay-btn"
      :disabled="isExpired || loading"
    >
      {{ loading ? '处理中...' : isExpired ? '已超时' : '去支付' }}
    </button>
  </div>
</template>

<style scoped>
.confirm-order {
  width: 700px;
  margin: 40px auto;
  padding: 30px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  font-family: "Microsoft YaHei";
}
h2 {
  text-align: center;
  color: #333;
}
.order-box {
  background: #fafafa;
  padding: 15px;
  border-radius: 8px;
  border: 1px solid #eee;
  margin-bottom: 20px;
}
.price {
  color: #e67e22;
  font-weight: bold;
}
.cart-preview ul {
  padding-left: 20px;
}
.pay-btn {
  width: 100%;
  padding: 12px;
  background-color: #4CAF50;
  border: none;
  color: white;
  font-size: 16px;
  border-radius: 8px;
  cursor: pointer;
}
.pay-btn:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}
</style>
