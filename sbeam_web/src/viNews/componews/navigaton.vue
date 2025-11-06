<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// 尝试解析 localStorage 中的 user 信息（兼容纯 id 或 JSON）
const rawUser = localStorage.getItem('sbeam_user')
let parsedUser: Record<string, unknown> | null = null
try {
  parsedUser = rawUser ? JSON.parse(rawUser) : null
} catch {
  parsedUser = null
}

const getField = (obj: Record<string, unknown> | null, keys: string[]) => {
  if (!obj) return undefined
  for (const k of keys) {
    const v = obj[k]
    if (typeof v === 'string' || typeof v === 'number') return String(v)
  }
  return undefined
}

const userId = getField(parsedUser, ['id', 'userId']) ?? rawUser ?? ''
const isLoggedIn = ref(!!userId)

// 个人中心下拉
const isHovered = ref(false)

// 消息功能状态
const showMessageDropdown = ref(false)
const messages = ref<Array<{ text: string; ts: number; read: boolean }>>([])
const unreadCount = ref(0)
let ws: WebSocket | null = null

// 后端 WebSocket 端口（如需改动请修改此处或改为从 env 获取）
const backendPort = 8080

const connectWebSocket = () => {
  if (!isLoggedIn.value || !userId) return
  const protocol = location.protocol === 'https:' ? 'wss' : 'ws'
  const host = location.hostname
  const url = `${protocol}://${host}:${backendPort}/ws/${encodeURIComponent(userId)}`
  try {
    ws = new WebSocket(url)
  } catch (e) {
    console.error('创建 WebSocket 失败', e)
    return
  }

  ws.onopen = () => {
    console.log('WebSocket 已连接 ->', url)
  }

  ws.onmessage = (evt) => {
    const text = String(evt.data)
    messages.value.unshift({ text, ts: Date.now(), read: false })
    unreadCount.value++
  }

  ws.onclose = () => {
    console.log('WebSocket 已断开，3s 后尝试重连')
    ws = null
    setTimeout(() => connectWebSocket(), 3000)
  }

  ws.onerror = (e) => {
    console.error('WebSocket 错误', e)
  }
}

onMounted(() => {
  if (isLoggedIn.value) connectWebSocket()
})

onBeforeUnmount(() => {
  if (ws) {
    ws.close()
    ws = null
  }
})

const goToUserSpace = () => {
  if (isLoggedIn.value) {
    router.push({ name: 'userspace' })
  } else {
    router.push('/login')
  }
}

// 登出功能
const logout = () => {
  console.log('点击了登出')
  localStorage.removeItem('sbeam_user')
  router.push('/login')
}

// 切换消息下拉（打开时将消息标记为已读）
const toggleMessages = () => {
  showMessageDropdown.value = !showMessageDropdown.value
  if (showMessageDropdown.value && unreadCount.value > 0) {
    messages.value.forEach((m) => (m.read = true))
    unreadCount.value = 0
  }
}
</script>

<template>
  <div class="navigation">
    <div class="nav-left">
      <router-link to="/" class="rout">logo</router-link>
      <router-link to="/" class="rout">商城</router-link>
      <router-link to="/" class="rout">仓库</router-link>
      <router-link to="/" class="rout">社区</router-link>
    </div>
    <div class="nav-right">
  <input />
      <button class="btn">搜索</button>

      <router-link to="/test" class="rout">测试用</router-link>

      <!-- 消息（有未读时显示角标），点击展开下拉 -->
      <span class="rout message-link" @click="toggleMessages">
        消息
        <span v-if="unreadCount > 0" class="badge">{{ unreadCount }}</span>
      </span>

      <transition name="fade">
        <div v-if="showMessageDropdown" class="message-dropdown">
          <div v-if="messages.length === 0" class="message-empty">暂无消息</div>
          <div v-for="m in messages" :key="m.ts" class="message-item" :class="{ unread: !m.read }">
            <div class="msg-text">{{ m.text }}</div>
            <div class="msg-time">{{ new Date(m.ts).toLocaleTimeString() }}</div>
          </div>
        </div>
      </transition>

      <!-- 个人中心 -->
      <span @click="goToUserSpace" @mouseenter="isHovered = true" @mouseleave="isHovered = false" class="rout">
        个人中心
      </span>

      <!-- 下拉菜单，只有在用户已登录并悬停时才显示-->
      <transition name="fade">
        <div v-if="isLoggedIn && isHovered" class="dropdown">
          <span @click="logout" class="rout" @mouseenter="isHovered = true" @mouseleave="isHovered = false">登出</span>
        </div>
      </transition>
    </div>
  </div>
</template>

<style scoped>
.navigation {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  min-height: 70px;
  background-color: rgba(0, 0, 0, 0.626);
  color: #fff;
}

.nav-left,
.nav-right {
  display: flex;
  align-items: center;
}

.nav-left {
  padding-left: 10px;
}

.nav-right {
  padding-right: 40px;
  position: relative;
  /* 使得下拉菜单相对导航栏右侧定位 */
}

/* 避免下拉菜单区域消失，留出空间 */
.rout {
  padding: 0 15px;
  text-decoration: none;
  color: #fff;
  outline: none;
}

.rout:hover {
  color: #adaafe;
  cursor: pointer
}

/* 下拉菜单样式 */
.dropdown {
  width: 80px;
  position: absolute;
  top: 44px;
  /* 距离导航栏的底部 70px */
  right: 40px;
  /* 定位到导航栏的右侧 */
  background-color: rgba(0, 0, 0, 0.626);
  color: #fff;
  padding: 10px;
  border-bottom-right-radius: 5px;
  border-bottom-left-radius: 5px;
  box-shadow: 2px 5px 15px rgb(0, 0, 0);
  z-index: 10;
  /* 确保下拉菜单在其他元素上层显示 */
}

.dropdown .rout {
  padding: 5px 10px;
  display: block;
}

.dropdown .rout:hover {
  color: #adaafe;
  cursor: pointer
}

/* 为下拉菜单添加过渡动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter,
.fade-leave-to

/* .fade-leave-active in <2.1.8 */
  {
  opacity: 0;
}


input {
  width: 250px;
  margin-top: 10px;
  margin-right: 0;
  padding: auto;
  height: 40px;
  margin-bottom: 10px;
  border-top-left-radius: 3px;
  border-bottom-left-radius: 3px;
  border: none;
  background-color: #343342;
  color: #fff;
  transition: all 0.25s;
  text-align: center;
  outline: none;
}

input::placeholder {
  color: #b4b0b0;
  font-size: 14px;
  font-weight: 300;
}

input:hover {
  background-color: #6f6c8b;
}

input:focus {
  background-color: aliceblue;
  width: 300px;
  color: #adaafe;
}

.btn {
  margin-left: 0;
  height: 40px;
  outline: none;
  background-color: #7a79a0;
  color: aliceblue;
  border: none;
  width: 60px;
  padding: 10px 15px;
  border-top-right-radius: 3px;
  border-bottom-right-radius: 3px;
  font-size: 15px;
  cursor: pointer;
}

.btn:hover {
  background-color: aliceblue;
  color: #adaafe;
}

/* 消息角标 */
.badge {
  display: inline-block;
  min-width: 18px;
  height: 18px;
  line-height: 18px;
  padding: 0 6px;
  border-radius: 9px;
  background: #ff4d4f;
  color: #fff;
  font-size: 12px;
  text-align: center;
  margin-left: 6px;
}

/* 消息下拉 */
.message-dropdown {
  width: 300px;
  max-height: 400px;
  overflow: auto;
  position: absolute;
  top: 44px;
  right: 120px;
  background-color: rgba(0, 0, 0, 0.85);
  color: #fff;
  padding: 8px;
  border-radius: 6px;
  box-shadow: 2px 5px 15px rgb(0 0 0 / 50%);
  z-index: 20;
}

.message-empty {
  padding: 10px;
  color: #b4b0b0;
  text-align: center;
}

.message-item {
  padding: 8px 10px;
  border-bottom: 1px solid rgba(255,255,255,0.04);
  display: flex;
  justify-content: space-between;
  gap: 8px;
}

.message-item.unread .msg-text {
  font-weight: 600;
}

.msg-text {
  max-width: 220px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: #fff;
}

.msg-time {
  font-size: 11px;
  color: #b4b0b0;
  white-space: nowrap;
}
</style>
