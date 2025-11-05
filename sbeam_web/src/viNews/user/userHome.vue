<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'

// 从 localStorage 获取用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')

// 提取用户ID和用户名
const userId = user.userId
const userName = user.userName

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
</script>

<template>
  <div class="main">
    <div class="user-profile">
      <!-- 显示用户头像 -->
      <div class="user-info">
        <img :src="userProfile.avatarUrl || '/user/harusekai.png'" class="userIMG" alt="用户头像" />
        <br />
        <span class="nickname">{{ userName }}</span>
      </div>

      <!-- 显示用户个人简介 -->
      <div class="bio">
        <strong>个人简介: </strong>{{ userProfile.bio || '暂无简介' }}
      </div>

      <!-- 其他用户信息展示 -->
      <!-- ... -->
      <botton>编辑</botton>
      
    </div>


  </div>

</template>

<style scoped>
.main{
  background-color: rgba(97, 97, 97, 0.653);
  height: 100%;
  width: 70%;

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
</style>
