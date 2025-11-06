<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { log } from 'console'
import Login from '@/views/logres/Login.vue'

// 从 localStorage 获取用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')

// 提取用户ID和用户名
const userId = user.userId
const userName = ref(user.userName) // 使用 ref 来响应式地管理昵称
const isSetting = ref(false)
const isEditing = ref(false) // 控制是否显示铅笔图标
const isEditingName = ref(false) // 控制是否进入昵称编辑模式
// 用于显示是否正在加载
const isLoading = ref(false)
const isEditingAvatar = ref(false) // 控制是否处于头像编辑模式
const avatarFile = ref<File | null>(null) // 存储选中的头像文件

// 用来存储用户详细信息
const userProfile = ref({
  avatarUrl: '', // 用户头像
  bio: '', // 个人简介
  // 其他用户详细信息...
})

// 获取用户信息
const fetchUserProfileName = async (userId: number) => {
  try {
    const response = await axios.get(`http://localhost:8080/user/${userId}`)
    userName.value = response.data.userName // 更新用户名
  } catch (error) {
    console.error('获取用户信息失败', error)
  }
}

// 获取用户信息
const fetchUserProfile = async (userId: number) => {
  try {
    const response = await axios.get(`http://localhost:8080/user/pro/${userId}`)
    userProfile.value = response.data

    const avatarFileName = response.data.avatarUrl // 假设返回的文件名字段是 avatarFileName

    const avatarUrl = await fetchAvatarUrl(avatarFileName)
    userProfile.value.avatarUrl = avatarUrl || ''
    userProfile.value.bio = response.data.bio || '' // 保留其他字段不变

    console.log('DDDDDD')
    console.log(userProfile.value.avatarUrl)
  } catch (error) {
    console.error('获取用户信息失败', error)
  }
}

// 获取头像 URL 并返回
const fetchAvatarUrl = async (fileName: string) => {
  try {
    const response = await axios.get(`http://localhost:8080/user/avatar/${fileName}`)
    console.log('FFFFFFFFFFF')

    console.log(response.data.avatarUrl)

    return response.data.avatarUrl // 返回 MinIO URL
  } catch (error) {
    console.error('获取头像 URL 失败', error)
    return '' // 失败时返回空字符串
  }
}

// 修改昵称

// 用于保存用户输入的新昵称
const newUserName = ref('')

// 修改用户名
const updateUserName = async () => {
  if (!newUserName.value.trim()) {
    alert('用户名不能为空')
    return
  }

  const token = localStorage.getItem('sbeam_token')
  console.log('CCCCCCC')

  console.log(token)

  if (!token) {
    alert('请先登录')
    return
  }

  isLoading.value = true
  try {
    // 向后端发送 PUT 请求
    const response = await axios.put(
      'http://localhost:8080/user/updateName',
      { userName: newUserName.value },
      {
        headers: {
          Authorization: `Bearer ${token}`, // 传递 JWT token
        },
      },
    )

    if (response.data.code === 200) {
      alert('用户名更新成功')
    } else {
      alert('用户名更新失败: ' + response.data.msg)
    }
  } catch (error) {
    console.error('更新用户名失败', error)
    alert('更新用户名失败')
  } finally {
    isLoading.value = false
  }
}

// 修改头像
const uploadAvatar = async () => {
  if (!avatarFile.value) {
    alert('请先选择头像')
    return
  }

  const formData = new FormData()
  formData.append('avatar', avatarFile.value)

  const token = localStorage.getItem('sbeam_token')
  if (!token) {
    alert('请先登录')
    return
  }

  isLoading.value = true
  try {
    // 发送请求上传头像到 MinIO 或后端
    const response = await axios.post('http://localhost:8080/user/uploadAvatar', formData, {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'multipart/form-data', // 重要，告诉后端我们上传的是文件
      },
    })

    if (response.data.code === 200) {
      alert('头像更新成功')
      userProfile.value.avatarUrl = response.data.avatarUrl // 更新头像 URL
    } else {
      alert('头像更新失败: ' + response.data.msg)
    }
  } catch (error) {
    console.error('上传头像失败', error)
    alert('上传头像失败')
  } finally {
    isLoading.value = false
  }
}

// 头像上传文件选择
const handleAvatarChange = (event: Event) => {
  const fileInput = event.target as HTMLInputElement
  if (fileInput.files) {
    avatarFile.value = fileInput.files[0]
  }
}

// 启动头像编辑模式
const startEditingAvatar = () => {
  isEditingAvatar.value = true
}

// 页面加载时获取用户信息
onMounted(async () => {
  if (userId) {
    await fetchUserProfile(userId)
    await fetchUserProfileName(userId)
  }
})

const setting = () => {
  console.log('点击了编辑')
  isSetting.value = true
  isEditing.value = true // 点击编辑按钮后显示铅笔图标
}

// 启动昵称编辑模式
const startEditingName = () => {
  isEditingName.value = true
}
</script>

<template>
  <div class="main">
    <div class="user-profile">
      <!-- 用户信息部分 -->
      <div class="user-info">
        <!-- 用户头像部分 -->
        <img
          v-if="!isEditingAvatar"
          :src="userProfile.avatarUrl || '/user/harusekai.png'"
          class="userIMG"
          alt="用户头像"
          @click="startEditingAvatar"
        />

        <!-- 头像上传区域，显示上传按钮 -->
        <div v-if="isEditingAvatar" class="avatar-upload-container">
          <input type="file" @change="handleAvatarChange" accept="image/*" />
          <button @click="uploadAvatar">上传头像</button>
        </div>
        <div class="nickname-container">
          <!-- 用户昵称 -->
          <span v-if="!isEditingName" class="nickname">{{ userName }}</span>

          <!-- 用户昵称编辑框 -->
          <input
            v-if="isEditingName"
            v-model="newUserName"
            placeholder="请输入新用户名"
            class="nickname-input"
            type="text"
          />

          <!-- 铅笔图标，只有在 isEditing 为 true 时显示 -->
          <span v-if="isEditing" @click="startEditingName" class="edit-icon">✏️</span>
        </div>

        <!-- 编辑按钮 -->
        <button class="setting" @click="setting">编辑</button>
      </div>

      <!-- 保存按钮，只有在编辑模式下才显示 -->
      <div v-if="isEditingName" class="save-button-container">
        <button :disabled="isLoading" @click="updateUserName">
          {{ isLoading ? '处理中...' : '保存新用户名' }}
        </button>
      </div>

      <!-- 显示用户个人简介 -->
      <div class="down">
        <div class="left"><strong>个人展柜: </strong>{{ userProfile.bio || '无' }}</div>
        <div class="right">游戏 社区 库存</div>
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

.nickname-container {
  display: flex;
  align-items: center; /* 使昵称和铅笔图标在一行 */
  position: relative; /* 为了让铅笔图标定位到昵称右侧 */
}

.nickname {
  font-size: 24px;
  font-weight: bold;
}

.nickname-input {
  font-size: 24px;
  font-weight: bold;
  padding: 5px;
  margin-right: 10px;
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

.edit-icon {
  margin-left: 10px; /* 给铅笔图标和昵称之间加点距离 */
  font-size: 20px;
  cursor: pointer;
}

.save-button-container {
  margin-top: 10px;
}

.save-button {
  background-color: #576f75;
  color: white;
  border: none;
  padding: 8px 15px;
  border-radius: 5px;
  cursor: pointer;
}

.save-button:hover {
  background-color: powderblue;
}

.down {
  display: flex;
  justify-content: space-between;
}
</style>
