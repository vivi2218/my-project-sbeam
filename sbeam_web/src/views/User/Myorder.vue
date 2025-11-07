<template>
  <div class="order-page">
    <div class="orderStyle">

      <!-- 订单列表 -->
      <div class="order-list">
        <!-- 遍历订单 -->
        <div
          v-for="order in orders"
          :key="order.orderId"
          class="order-card"
        >
          <div class="order-header">
            <span class="order-id">订单号: {{ order.orderNumber }}</span>
            <span
              class="order-status"
              :class="{
                'status-paid': order.orderStatus === 'paid',
                'status-unpaid': order.orderStatus === 'unpaid',
                'status-cancelled': order.orderStatus === 'cancelled'
              }"
            >
              {{ formatStatus(order.orderStatus) }}
            </span>
          </div>

          <div class="order-body">
            <!-- 暂无游戏封面数据，可后期关联订单详情 -->
            <img class="game-cover" src="/gameimg/6.jpg" alt="Game Cover" />
            <div class="game-info">
              <h3 class="game-title">订单金额：￥{{ order.finalPrice }}</h3>
              <p class="game-time">下单时间：{{ formatDate(order.createdAt) }}</p>
            </div>
          </div>

          <div class="order-footer">
            <button class="btn btn-detail" @click="viewDetail(order.orderId)">查看详情</button>

            <template v-if="order.orderStatus === 'unpaid'">
              <button class="btn btn-pay" @click="payOrder(order)">立即支付</button>
              <button class="btn btn-cancel" @click="cancelOrder(order.orderId)">取消订单</button>
            </template>

            <template v-else-if="order.orderStatus === 'paid'">
              <button class="btn btn-download">下载游戏</button>
            </template>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()
const userId = 1 // 暂时写死，后期可从 token 或路由传参
const orders = ref([])

// ===== 获取订单数据 =====
const getOrders = async () => {
  try {
    const res = await axios.get(`http://localhost:8080/myorder/user/${userId}`)
    if (Array.isArray(res.data)) {
      orders.value = res.data
    } else {
      console.warn('订单返回不是数组:', res.data)
    }
  } catch (error) {
    console.error('获取订单失败:', error)
  }
}

// ===== 支付功能 =====
const payOrder = async (order) => {
  try {
    const res = await axios.post('http://localhost:8080/paymentRecords/alipay', order, {
      headers: { 'Content-Type': 'application/json' },
    })
    const div = document.createElement('div')
    div.innerHTML = res.data
    document.body.appendChild(div)
    document.forms[0].submit() // 自动跳转支付宝
  } catch (error) {
    console.error('支付失败:', error)
  }
}

// ===== 取消订单 =====
const cancelOrder = async (orderId) => {
  try {
    await axios.put(`http://localhost:8080/myorder/cancel/${orderId}`)
    getOrders()
  } catch (error) {
    console.error('取消订单失败:', error)
  }
}

// ===== 查看详情 =====
const viewDetail = (orderId) => {
  router.push({ path: `/order/details/${orderId}` })
}

// ===== 工具函数 =====
const formatDate = (arr) => {
  if (!Array.isArray(arr)) return ''
  const [y, m, d, h, min, s] = arr
  return `${y}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')} ${String(h).padStart(2, '0')}:${String(min).padStart(2, '0')}`
}

const formatStatus = (status) => {
  switch (status) {
    case 'paid': return '已支付'
    case 'unpaid': return '待支付'
    case 'cancelled': return '已取消'
    default: return status
  }
}

onMounted(() => {
  getOrders()
})
</script>

<style scoped>
/* 你原来的样式完全保留 */
body {
  overflow-x: hidden;
  background-color: rgb(14, 16, 14);
}

.orderStyle {
  width: 100vw;
  max-width: 1600px;
  margin: 0 auto;
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
  flex: 1;
}

.order-card {
  background: #2a2a2a;
  border-radius: 12px;
  padding: 15px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
  transition: all 0.3s ease;
}
.order-card:hover {
  border: 6px solid #076f1d;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
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
.status-paid {
  background-color: #28a745;
  color: white;
}
.status-cancelled {
  background-color: #dc3545;
  color: white;
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
  background-color: #ffffff;
  color: #363636;
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
