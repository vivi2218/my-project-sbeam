<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'

// 从 localStorage 获取用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')

// 提取用户ID和用户名
const userId = user.userId
const userName = user.userName
const isSetting = ref(false)

// 用来存储用户详细信息
const userProfile = ref({
  avatarUrl: '',  // 用户头像
  bio: '',  // 个人简介
  // 其他用户详细信息...
})

// 获取用户详细信息
const fetchUserProfile = async (userId: number) => {
  try {
    const response = await axios.get(`/user/pro/${userId}`)
    userProfile.value = response.data
  } catch (error) {
    console.error('获取用户详细信息失败', error)
  }
}

// 页面加载时获取用户信息
onMounted(async () => {
  if (userId) {
    await fetchUserProfile(userId)
  }
})

const setting = () => {
  console.log("点击了编辑")
  isSetting.value = true
}

</script>

<template>
  <div class="main">
    <div class="user-profile">
      <!-- 用户信息部分 -->
      <div class="user-info">
        <!-- 用户头像 -->
        <img :src="userProfile.avatarUrl || '/user/harusekai.png'" class="userIMG" alt="用户头像" />
        <span class="nickname">{{ userName }}</span>

        <!-- 绑定 Steam 按钮 -->
        <button class="setting" @click="setting">编辑 Steam</button>
      </div>

      <!-- 显示用户个人简介 -->
      <div class="down">
        <div class="left">
          <strong>个人展柜: </strong>{{ userProfile.bio || '无' }}
        </div>
        <div class="right">
          游戏
          社区
          库存
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.main {
  background-color: rgba(97, 97, 97, 0.653);
  height: 100%;
  width: 70%;
  position: relative;
}

.user-profile {
  display: flex;
  flex-direction: column;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.user-info {
  display: flex;
  align-items: center;
  flex-direction: column;
  position: relative;
}

.userIMG {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  margin-right: 20px;
}

.nickname {
  font-size: 24px;
  font-weight: bold;
}

.bio {
  margin-top: 10px;
}

strong {
  font-weight: bold;
}

.setting {
  position: absolute;
  right: 0;
  top: 0;
  background-color: #576f75;
  color: #adaafe;
  border: none;
  padding: 8px 15px;
  border-radius: 5px;
  cursor: pointer;
}

.setting:hover {
  background-color: powderblue;
}

.down {
  display: flex;
  justify-content: space-between;
}
</style>
