<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
const router = useRouter()

const userName = ref('')
const password = ref('')
const email = ref('') // 改为邮箱
const code = ref('')
const codeSent = ref(false)

// 倒计时相关
const countdown = ref(0)
let timer: number | null = null

// 启动倒计时
const startCountdown = () => {
  countdown.value = 60
  timer = window.setInterval(() => {
    countdown.value--
    if (countdown.value <= 0) {
      clearInterval(timer!)
      timer = null
    }
  }, 1000)
}
// 发送验证码
const sendCode = async () => {
  if (!email.value) {
    alert('请输入邮箱')
    return
  }
  try {
    const res = await fetch('http://localhost:8080/user/sendCode', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: email.value }),
    })
    const data = await res.json()
    if (data.success) {
      codeSent.value = true
      alert('验证码发送成功')
      startCountdown() // <-- 调用这里
    } else {
      alert('发送失败: ' + (data.message || '请重试'))
    }
  } catch (err) {
    console.error(err)
    alert('发送验证码失败，网络错误')
  }
}

//注册
const register = () => {
  console.log('注册信息:', userName.value, password.value, email.value, code.value)

  //localhost:8080/user
  fetch('http://localhost:8080/user', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      user_name: userName.value,
      password: password.value,
      email: email.value,
      code: code.value, // 前端输入的验证码
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      console.log('注册成功:', data)

      if (!userName.value || !password.value || !email.value || !code.value) {
        alert('请输入完整信息')
        return
      }

      if (data.success) {
        // 假设后端返回 { success: true } 表示注册成功
        console.log('注册成功，跳转到登录页')
        router.push('/login')
      } else {
        console.error('注册失败:', data.message || '未知错误')
        alert('注册失败: ' + (data.message || '请检查输入信息'))
      }
    })
    .catch((error) => {
      console.error('网络请求失败:', error)
      alert('注册失败，网络错误')
    })
}
</script>

<template>
  <div class="container">
    <div id="logo">
      <img src="@/assets/img/Sbeam.png" alt="logo" />
      sbeam
    </div>

    <div class="form">
      <input v-model="userName" type="text" placeholder="账号" />
      <input v-model="password" type="password" placeholder="密码" />

      <div class="phone">
        <input v-model="email" type="text" placeholder="邮箱" />
        <button class="btn-send" @click="sendCode" :disabled="countdown > 0">
          <template v-if="countdown > 0"> {{ countdown }}<br />秒后重发 </template>
          <template v-else> 发送<br />验证码 </template>
        </button>
      </div>

      <input v-model="code" type="text" placeholder="验证码" />

      <button class="btn-login" @click="register">注册</button>
    </div>
  </div>
</template>

<style scoped>
html {
  zoom: 110%;
}

/* App.vue 或 main.css */
html,
body,
#app {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  /* 关键：高度100% */
  overflow-x: hidden; /* 防止水平滚动 */
}

.container {
  width: 100%;
  max-width: 1800px;
  margin: 0 auto; /*关键：居中 */
}

body {
  font-family: 'Segoe UI', Arial, sans-serif;
}

.container {
  position: relative;
  text-align: center;
  color: #adaafe;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(to top left, #5a005a, #444, #013354);
}

#logo {
  position: relative;
  width: 200px;
  height: 50px;
  margin: 20px;
  font-size: 50px;
  font-family: fantasy;
  color: antiquewhite;
}

#logo img {
  width: 50px;
  vertical-align: middle;
}

.form {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}

.form input {
  outline: none;
  border: 1px solid #938282;
  background-color: #65637f;
  width: 250px;
  padding: 10px 15px;
  border-radius: 3px;
  text-align: center;
  color: #b9abff;
  font-size: 15px;
  transition: 0.25s;
}

.form input:focus::placeholder {
  color: transparent;
}

.form input:hover {
  background-color: azure;
}

.form input:focus {
  background-color: aliceblue;
  width: 300px;
  color: #adaafe;
}

.phone {
  display: flex;
  align-items: center;
  gap: 5px;
}

.phone input {
  height: 40px;
  width: 170px;
  border-radius: 3px;
  padding: 0 10px;
}

.phone input:focus {
  width: 230px;
}

.phone button {
  height: 40px;
  width: 75px;
  border-radius: 3px;
  background-color: #adaafe;
  color: aliceblue;
  border: none;
  cursor: pointer;
}

.phone button:hover {
  background-color: aliceblue;
  color: #adaafe;
}

.btn-send {
  outline: none;
  background-color: #adaafe;
  color: aliceblue;
  border: none;
  width: 250px;
  padding: 0px 10px;
  border-radius: 3px;
  font-size: 14px;
  cursor: pointer;
  text-decoration: none;
  text-align: center;
}

.btn-login {
  outline: none;
  background-color: #adaafe;
  color: aliceblue;
  border: none;
  width: 250px;
  padding: 10px 15px;
  border-radius: 3px;
  font-size: 15px;
  cursor: pointer;
  text-decoration: none;
  text-align: center;
}

.btn-login:hover {
  background-color: aliceblue;
  color: #adaafe;
}
</style>
