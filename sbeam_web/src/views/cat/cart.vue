<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { computed } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isLoading = ref(false)
const cartItems = ref([])
// 取 token
const token = localStorage.getItem('sbeam_token')

onMounted(async () => {
  const res = await axios.get('http://localhost:8080/cart', {
    headers: { Authorization: token }, // 后端用 token 获取 userId
  })
  cartItems.value = res.data
})

// 计算总价
const totalPrice = computed(() =>
  cartItems.value.reduce((sum, item) => sum + Number(item.gamePrice || 0), 0),
)

// 删除购物车商品
const removeItem = async (cartId) => {
  try {
    await axios.delete(`http://localhost:8080/cart/${cartId}`, {
      headers: { Authorization: token },
    })
    cartItems.value = cartItems.value.filter((item) => item.cartId !== cartId)
  } catch (e) {
    console.error('删除失败', e)
  }
}
const checkout = async () => {
  if (cartItems.value.length === 0) {
    alert('购物车为空，无法结算')
    return
  }
  isLoading.value = true
  try{
    const res = await axios.post(
      'http://localhost:8080/myorder/create/1',
       totalPrice.value,

      {
        headers: { Authorization: token ,
          'Content-Type': 'application/json'
        },
      },
    )
      console.log(res);
      if(res.data.code===200){
        const { order } = res.data.data
        //跳转到确认订单页面
        router.push({path:'/confirmorder',
        query: { userId: order.userId, orderNumber: order.orderNumber }
        })
      }
    }finally{
    isLoading.value = false
  }

}
</script>

<template>
  <div class="cart">
    <div class="container">
      <h2>我的购物车</h2>

      <div v-for="item in cartItems" :key="item.id" class="cart-item">
        <img :src="`/gameimg/${item.gameId}.jpg`" alt="游戏封面" @error="onImageError" />

        <div class="cart-info">
          <h3>{{ item.gameName }}</h3>
          <p>{{ item.tag }} | {{ item.config }}</p>
        </div>
        <div class="price">{{ item.gamePrice }} 元</div>
        <div class="remove" @click="removeItem(item.cartId)">删除</div>
      </div>

      <div class="checkout">
        <p>总价：{{ totalPrice }} 元</p>
        <button @click="checkout" :disabled="isLoading">
            {{ isLoading ? '创建订单中...' : '去结算' }}</button>
      </div>
    </div>
  </div>
</template>

<style>
.cart {
  width: 100vw;
  max-width: 1800px;
  background-color: #1a0325;
}
.container {
  width: 100vw;
  max-width: 1800px;
  margin: 0 auto; /*关键：居中 */
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #1e1e1e;
  box-sizing: border-box;
  overflow-y: auto;
  font-family: 'Microsoft Yahei', sans-serif;
  color: #f5f5f5;
}
/* ========== 基础样式 ========== */

h2 {
  margin-bottom: 25px;
  font-size: 22px;
  border-left: 4px solid #8e13c8;
  padding-left: 12px;
}

/* ========== 购物车商品卡片 ========== */
.cart-item {
  display: flex;
  align-items: center;
  background: #1e1e2f;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 20px;
  transition: 0.4s;
  border: 1px solid transparent;
}
.cart-item:hover {
  transform: translateY(-5px);
  border: 1px solid #0f0;
  box-shadow:
    0 0 15px #0f0,
    0 0 25px #0f0;
}

.cart-item img {
  width: 90px;
  height: 90px;
  border-radius: 10px;
  object-fit: cover;
}

.cart-info {
  flex: 2;
  margin-left: 20px;
}
.cart-info h3 {
  margin: 0;
  font-size: 18px;
  color: #fff;
}
.cart-info p {
  margin: 5px 0 0;
  font-size: 14px;
  color: #aaa;
}

/* 价格与删除 */
.price {
  font-size: 18px;
  font-weight: bold;
  color: #ffcc80;
  margin-right: 20px;
}
.remove {
  color: #f44336;
  cursor: pointer;
  font-size: 14px;
  transition: 0.3s;
}
.remove:hover {
  text-shadow: 0 0 8px #f44336;
}

/* ========== 结算区域 ========== */
.checkout {
  background: #1f1f2e;
  padding: 20px;
  border-radius: 12px;
  text-align: right;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.6);
}
.checkout p {
  font-size: 20px;
  margin-bottom: 15px;
}
.checkout button {
  background: linear-gradient(135deg, #0f0, #0f0);
  border: none;
  padding: 12px 30px;
  color: #fff;
  font-size: 16px;
  border-radius: 8px;
  cursor: pointer;
  transition: 0.3s;
  box-shadow: 0 0 10px #ff9800aa;
}
.checkout button:hover {
  background: linear-gradient(135deg, #dd0df0, #e00fb6);
  box-shadow:
    0 0 15px #c50ae2,
    0 0 30px #d807c7;
  transform: scale(1.05);
}
</style>
