<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// 判断用户是否已登录
const isLoggedIn = ref(!!localStorage.getItem('sbeam_user'))

// 控制悬停时是否显示下拉菜单
const isHovered = ref(false)

const goToUserSpace = () => {
  if (isLoggedIn.value) {
    // 如果已登录，跳转到个人中心
    router.push({ name: 'userspace' })
  } else {
    // 如果未登录，跳转到登录页面
    router.push('/login')
  }
}

// 登出功能
const logout = () => {
  localStorage.removeItem('sbeam_user')  // 清除本地存储中的用户信息
  router.push('/login')  // 跳转到登录页
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
      <router-link to="/test" class="rout">测试用</router-link>
      <router-link to="/" class="rout">消息</router-link>

      <!-- 个人中心 -->
      <span @click="goToUserSpace" @mouseover="isHovered = true" @mouseleave="isHovered = false" class="rout">
        个人中心
      </span>

      <!-- 下拉菜单，只有在用户已登录并悬停时才显示-->
      <div v-if="isLoggedIn && isHovered" class="dropdown">
        <span @click="logout" class="rout">登出</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.navigation {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 70px;
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

.rout {
  padding: 0 15px;
  text-decoration: none;
  color: #fff;
  outline: none;
}

.rout:hover {
  color: #adaafe;
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
}

.dropdown .rout {
  padding: 5px 10px;
  display: block;
}

.dropdown .rout:hover {
  color: #adaafe;
}
</style>
