<template>
  <div class="order-details-page">
    <div class="order-details-container">
      <h1 class="page-title">订单详情</h1>

      <!-- 订单基本信息 -->
      <div v-if="loading" class="loading">
        加载中...
      </div>

      <div v-else-if="order" class="order-info-card">
        <div class="order-header">
          <h2>订单信息</h2>
          <span class="order-status" :class="`status-${order.orderStatus}`">
            {{ formatStatus(order.orderStatus) }}
          </span>
        </div>

        <div class="order-content">
          <div class="order-meta">
            <p><strong>订单号：</strong>{{ order.orderNumber }}</p>
            <p><strong>订单金额：</strong>￥{{ order.finalPrice }}</p>
            <p><strong>下单时间：</strong>{{ formatDate(order.createdAt) }}</p>
          </div>
        </div>
      </div>

      <!-- CDKey信息 -->
      <div v-if="order && order.orderStatus === 'paid'" class="cdkey-section">
        <h3>游戏激活码 (CDKey)</h3>
        <div v-if="cdkeys.length > 0" class="cdkey-list">
          <div v-for="(cdkey, index) in cdkeys" :key="index" class="cdkey-card">
            <div class="game-info">
              <div class="game-image-container">
                <img v-if="cdkey.gameId"
                     :src="`/gameimg/${cdkey.gameId}.jpg`"
                     :alt="cdkey.gameName"
                     class="game-image">
                <div v-else class="game-image-placeholder">
                  游戏封面
                </div>
              </div>
              <h4>{{ cdkey.gameName }}</h4>
              <p>创建时间：{{ cdkey.createTime }}</p>
            </div>
            <div class="cdkey-value">
              <code>{{ cdkey.cdkey }}</code>
              <button class="copy-btn" @click="copyToClipboard(cdkey.cdkey)">复制</button>
            </div>
          </div>
        </div>
        <div v-else class="no-cdkey">
          暂无CDKey信息，请稍后再试。
        </div>
      </div>

      <!-- 未支付的订单提示 -->
      <div v-if="order && order.orderStatus !== 'paid'" class="payment-required">
        <p>请完成支付后查看游戏激活码</p>
        <button class="pay-now-btn" @click="payOrder(order)">立即支付</button>
      </div>

      <div class="action-buttons">
        <button class="back-btn" @click="goBack">返回订单列表</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()
const orderId = ref(route.params.id)
const order = ref(null)
const cdkeys = ref([])
const loading = ref(true)
const token = localStorage.getItem('sbeam_token') || ''

// 获取订单详情
const getOrderDetails = async () => {
  try {
    loading.value = true
    // 获取订单信息
    const orderRes = await axios.get(`http://localhost:8080/myorder/${orderId.value}`, {
        headers: { Authorization: token }
      })
      order.value = orderRes.data

    // 如果订单已支付，获取CDKey
    if (order.value && order.value.orderStatus === 'paid') {
      await getOrderCdkeys()
    }
  } catch (error) {
    console.error('获取订单详情失败:', error)
  } finally {
    loading.value = false
  }
}

// 获取订单对应的CDKey
const getOrderCdkeys = async () => {
  try {
    const cdkeyRes = await axios.get(`http://localhost:8080/cdkey/order/${orderId.value}`, {
      headers: { Authorization: token }
    })
    console.log('CDKey数据:', cdkeyRes)
    cdkeys.value = cdkeyRes.data || []
  } catch (error) {
    console.error('获取CDKey失败:', error)
  }
}

// 复制CDKey到剪贴板
const copyToClipboard = (text) => {
  navigator.clipboard.writeText(text).then(() => {
    alert('CDKey已复制到剪贴板')
  }).catch(err => {
    console.error('复制失败:', err)
    alert('复制失败，请手动复制')
  })
}

// 立即支付
const payOrder = async (order) => {
  try {
    const res = await axios.post('http://localhost:8080/paymentRecords', order, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      }
    })
    const div = document.createElement('div')
    div.innerHTML = res.data
    document.body.appendChild(div)
    document.forms[0].submit() // 自动跳转支付宝
  } catch (error) {
    console.error('支付失败:', error)
    alert('支付请求失败，请稍后重试')
  }
}

// 格式化日期
const formatDate = (arr) => {
  if (!Array.isArray(arr)) return ''
  const [y, m, d, h, min, s] = arr
  return `${y}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')} ${String(h).padStart(2, '0')}:${String(min).padStart(2, '0')}`
}

// 格式化订单状态
const formatStatus = (status) => {
  switch (status) {
    case 'paid': return '已支付'
    case 'unpaid': return '待支付'
    case 'cancelled': return '已取消'
    default: return status
  }
}

// 返回上一页
const goBack = () => {
  router.push('/User/Myorder')
}

onMounted(() => {
  getOrderDetails()
})
</script>

<style scoped>
.order-details-page {
  width: 90%;
  max-width: 1200px;
  margin: 2rem auto;
  padding: 2rem;
  background-color: #1a1a1a;
  color: #f5f5f5;
}

.order-details-container {
  background-color: #212121;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
  min-height: auto;
  height: auto;
  display: block;
}

.page-title {
  text-align: center;
  margin-bottom: 2rem;
  color: #076f1d;
}

.loading {
  text-align: center;
  padding: 3rem;
  color: #999;
}

.order-info-card {
  background-color: #2a2a2a;
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 2rem;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  border-bottom: 1px solid #333;
  padding-bottom: 1rem;
}

.order-header h2 {
  margin: 0;
  color: #fff;
}

.order-status {
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: bold;
}

.status-paid {
  background-color: #28a745;
  color: white;
}

.status-unpaid {
  background-color: #ffc107;
  color: #333;
}

.status-cancelled {
  background-color: #dc3545;
  color: white;
}

.order-content {
  padding: 1rem 0;
}

.order-meta {
  display: flex;
  flex-direction: column;
  gap: 0.8rem;
}

.order-meta p {
  margin: 0;
  color: #ccc;
}

.cdkey-section {
  margin-top: 2rem;
}

.cdkey-section h3 {
  color: #076f1d;
  margin-bottom: 1.5rem;
  border-left: 4px solid #076f1d;
  padding-left: 1rem;
}

.cdkey-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.cdkey-card {
  background-color: #2a2a2a;
  border-radius: 8px;
  padding: 1.5rem;
  border: 1px solid #333;
  transition: all 0.3s ease;
}

.cdkey-card:hover {
  border-color: #076f1d;
  box-shadow: 0 2px 10px rgba(7, 111, 29, 0.2);
}

.game-info h4 {
  margin: 0 0 0.5rem 0;
  color: #fff;
}

.game-info p {
  margin: 0;
  color: #999;
  font-size: 0.9rem;
}

.cdkey-value {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 1rem;
  padding: 1rem;
  background-color: #1a1a1a;
  border-radius: 4px;
  border: 1px dashed #444;
}

.cdkey-value code {
  font-family: 'Courier New', monospace;
  color: #076f1d;
  font-size: 1.1rem;
  letter-spacing: 1px;
}

.copy-btn {
  background-color: #076f1d;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.copy-btn:hover {
  background-color: #095f1a;
}

.no-cdkey {
  text-align: center;
  padding: 2rem;
  color: #999;
  background-color: #2a2a2a;
  border-radius: 8px;
}

.payment-required {
  text-align: center;
  padding: 2rem;
  background-color: #2a2a2a;
  border-radius: 8px;
  margin-top: 2rem;
}

.pay-now-btn {
  background-color: #ffc107;
  color: #333;
  border: none;
  padding: 0.8rem 2rem;
  border-radius: 4px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  margin-top: 1rem;
  transition: background-color 0.3s ease;
}

.pay-now-btn:hover {
  background-color: #e0a800;
}

.action-buttons {
    margin-top: 2rem;
    text-align: center;
  }

  .back-btn {
    background-color: #666;
    color: white;
    border: none;
    padding: 0.8rem 2rem;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  .back-btn:hover {
    background-color: #777;
  }

  .game-image-container {
    width: 100%;
    height: 150px;
    margin-bottom: 1rem;
    overflow: hidden;
    border-radius: 4px;
    background-color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .game-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
  }

  .game-image:hover {
    transform: scale(1.05);
  }

  .game-image-placeholder {
    color: #666;
    text-align: center;
    padding: 1rem;
  }
</style>
