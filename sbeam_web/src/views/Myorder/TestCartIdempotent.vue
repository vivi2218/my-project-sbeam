<template>
  <div class="order-page">
    <h2>下单测试（幂等验证）</h2>

    <button @click="createOrder" :disabled="loading">
      {{ loading ? '下单中...' : '立即下单' }}
    </button>

    <p v-if="message" style="margin-top:10px;color:green;">{{ message }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

// 模拟登录后的用户ID（实际应从JWT解析）
const userId = 1
const loading = ref(false)
const message = ref('')

// 临时存储token与value
let formtoken = ''
let formvalue = ''

// 第一步：先去获取幂等token
async function getToken() {
  const res = await axios.get(`http://localhost:8080/idempotent/createToken?userId=${userId}`)
  // 后端返回形如 { data: { formtoken, formvalue } }
  console.log('获取token响应:', res)
  formtoken = res.data.data.formtoken
  formvalue = res.data.data.formvalue
  console.log('✅ 获取token成功:', formtoken, formvalue)
}

// 第二步：下单请求
async function createOrder() {
  try {
    loading.value = true
    message.value = ''

    // 1. 获取 token
    await getToken()

    // 2. 模拟购物车数据
    const orderData = {
      gameId: 1001,
      price: 59.99
    }

    // 3. 发起创建订单请求（带上两个头）
    const res = await axios.post(`http://localhost:8080/myorder/create/${userId}`,{}, {
      headers: {
        formtoken,
        formvalue
      }
    })

    message.value = '✅ 下单成功！订单已创建。'
    console.log('✅ 订单创建成功:', res)
  } catch (err) {
    console.error('❌ 订单创建失败:', err)
    message.value = '❌ 重复提交或token失效！'
  } finally {
    loading.value = false
  }
}
</script>
