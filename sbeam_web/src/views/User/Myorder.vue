<template>
  <div class="order-page">
    <div class="orderStyle">
      <!-- 订单筛选按钮 -->
      <div class="order-filter">
        <button
          class="filter-btn"
          :class="{ active: currentFilter === 'all' }"
          @click="changeFilter('all')"
        >
          全部订单
        </button>
        <button
          class="filter-btn"
          :class="{ active: currentFilter === 'paid' }"
          @click="changeFilter('paid')"
        >
          已支付
        </button>
        <button
          class="filter-btn"
          :class="{ active: currentFilter === 'unpaid' }"
          @click="changeFilter('unpaid')"
        >
          未支付
        </button>
        <button
          class="filter-btn"
          :class="{ active: currentFilter === 'cancelled' }"
          @click="changeFilter('cancelled')"
        >
          已取消
        </button>
      </div>

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
              <h3 class="game-title">{{ order.gameName || '游戏名称' }}等游戏</h3>
              <p class="game-price">订单金额：￥{{ order.finalPrice }}</p>
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
              <!-- 下载游戏功能已移除 -->
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
const orders = ref([])
const currentFilter = ref('all') // 默认显示全部订单
const token=localStorage.getItem('sbeam_token') || ''
const sbeam_user = localStorage.getItem('sbeam_user')
const userId= sbeam_user ? JSON.parse(sbeam_user).userId : ''

// ===== 获取订单数据 =====
const getOrders = async () => {
  try {
    let url = `http://localhost:8080/myorder/user/${userId}`
    // 如果不是全部订单，则添加状态筛选参数
    if (currentFilter.value !== 'all') {
      url += `/status/${currentFilter.value}`
    }

    const res = await axios.get(url, {
      headers: { Authorization: token || '' },
    })
    if (Array.isArray(res.data)) {
      orders.value = res.data
    } else {
      console.warn('订单返回不是数组:', res.data)
    }
  } catch (error) {
    console.error('获取订单失败:', error)
  }
}

// ===== 切换筛选条件 =====
const changeFilter = (filter) => {
  currentFilter.value = filter
  getOrders() // 切换筛选后重新获取订单数据
}

// ===== 支付功能 =====
const payOrder = async (order) => {
  try {
    const res = await axios.post('http://localhost:8080/paymentRecords', order, {
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
body {
  background-color: rgb(14, 16, 14);
}
.order-page {
  width: 90%;
  max-width:2500px;
  margin: 0 auto;/*水平居中 */
  padding: 2rem;
  min-height: 100vh;
  background: linear-gradient(to top left, #013354, #444, #5a005a);
  background-attachment: fixed;
}

/* 筛选按钮样式 */
.order-filter {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.filter-btn {
  padding: 0.5rem 1.5rem;
  border: 2px solid #555;
  background-color: #2a2a2a;
  color: #f5f5f5;
  border-radius: 25px;
  cursor: pointer;
  font-size: 1rem;
  transition: all 0.3s ease;
}

.filter-btn:hover {
  background-color: #3a3a3a;
  border-color: #076f1d;
  transform: translateY(-2px);
}

.filter-btn.active {
  background-color: #076f1d;
  border-color: #076f1d;
  color: white;
  box-shadow: 0 4px 12px rgba(7, 111, 29, 0.3);
}

.orderStyle {
  width: 100%;
  max-width: 4500px;
  margin: 2rem auto;
  background-color: #212121;
  box-sizing: border-box;
  padding: 2rem;
  font-family: 'Microsoft Yahei', sans-serif;
  color: #f5f5f5;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
}

.order-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.order-card {
  min-height: 60px;
  background: #2a2a2a;
  border-radius: 12px;
  padding: 1rem;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
}

.order-card:hover {
  border: 2px solid #076f1d;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
  transform: translateY(-3px);
}

.order-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 0.5rem;
  font-size: 14px;
}

.order-status {
  font-weight: bold;
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
  font-size: 0.85rem;
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
  flex: 1;
}



.game-info {
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.game-price {
  font-size: 16px;
  color: #076f1d;
  margin: 0.2rem 0 0.3rem 0;
  font-weight: 500;
}

.game-title {
  margin: 0 0 0.3rem 0;
  font-size: 16px;
  font-weight: bold;
}

.game-time {
  font-size: 13px;
  color: #aaa;
  margin: 0;
}

.order-footer {
  display: flex;
  justify-content: flex-end;
  gap: 0.5rem;
  margin-top: 0.5rem;
}

.btn {
  padding: 0.3rem 0.8rem;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.8rem;
  transition: all 0.2s ease;
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

.btn-detail {
  background-color: #fff;
  color: #1e1e1e;
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
