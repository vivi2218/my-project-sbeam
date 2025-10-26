<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const username = ref('')
const password = ref('')
const containerClass = ref('container')
const router = useRouter()

const login = async () => {
  try {
    const resp = await axios.post('http://localhost:8080/auth/login', {
      username: username.value,
      password: password.value,
    })

    // 根据 code 判断是否成功
    if (resp.data && resp.data.code === 200) {
      const token = resp.data.token
      localStorage.setItem('sbeam_token', token)

      // 保存用户信息
      const userData = {
        userId: resp.data.userId,
        username: resp.data.username,
        email: resp.data.email,
      }
      localStorage.setItem('sbeam_user', JSON.stringify(userData))

      axios.defaults.headers.common['Authorization'] = token

      containerClass.value = 'container success'

      // 跳转首页
      setTimeout(() => router.push('/'), 400)
    } else {
      // 显示后端返回的 msg 提示
      alert(resp.data.msg || '登录失败')
    }
  } catch (e) {
    console.error('登录请求失败:', e)
    alert('登录请求失败，网络或服务器错误')
  }
}

// const login = async () => {
//   if (!username.value || !password.value) {
//     alert('请输入账号和密码')
//     return
//   }

//   try {
//     const resp = await axios.post(
//       'http://localhost:8080/auth/login',
//       {
//         username: username.value,
//         password: password.value,
//       },
//       {
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       },
//     )

//     // 后端返回数据示例：
//     // { "code": 200, "token": "xxx", "userId": 1 }
//     if (resp.data.code === 200 && resp.data.token) {
//       const token = resp.data.token
//       localStorage.setItem('sbeam_token', token)
//       axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
//       containerClass.value = 'container success'

//       alert('登录成功，Token 已保存')
//       // 跳转首页
//       setTimeout(() => router.push('/'), 400)
//     } else {
//       alert(resp.data.msg || '登录失败')
//     }
//   } catch (e) {
//     console.error('登录请求失败', e)
//     alert('登录请求失败，网络或服务器错误')
//   }
// }
</script>

<template>
  <div :class="containerClass">
    <h1>Ciallo～(∠・ω< )⌒☆</h1>

    <div class="form">
      <input v-model="username" type="text" placeholder="账号" />
      <input v-model="password" type="password" placeholder="密码" />
      <button class="btn-login" @click="login">登录</button>
      <router-link to="/register">
        <button class="btn-register">注册</button>
      </router-link>
    </div>

  </div>
</template>

<style scoped>

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  width: ;
}

html,
body {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0;
  padding: 0;
  width: 100vw;
  height: 100%;
  overflow-x: hidden; /* 防止水平滚动 */
}

.container {
  width: 100%;
  max-width: 1800px;
  margin: 0 auto; /*关键：居中 */

  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #adaafe;
  box-sizing: border-box;
  background: linear-gradient(to top left, #013354, #444, #5a005a);

  overflow: hidden;
}

.container.success h1 {
  animation: slide-out 2s ease-in-out forwards;
}

.container.success .form {
  opacity: 0;
  transition: opacity 0.5s;
}

.container h1 {
  font-size: 40px;
  font-weight: 100;
  letter-spacing: 2px;
  margin-bottom: 15px;
  transition: 1s ease-in-out;
}

.form {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
}

.form input {
  width: 250px;
  padding: 10px 15px;
  margin-bottom: 10px;
  border-radius: 3px;
  border: none;
  background-color: #65637f;
  color: #fff;
  transition: all 0.25s;
  text-align: center;
  outline: none;
}

.form input::placeholder {
  color: #b4b0b0;
  font-size: 14px;
  font-weight: 300;
}

.form input:hover {
  background-color: #6f6c8b;
}

.form input:focus {
  background-color: aliceblue;
  width: 300px;
  color: #adaafe;
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
  transition:
    background-color 0.25s,
    color 0.25s;
}
.btn-register {
  outline: none;
  background-color: #3d3d71;
  color: aliceblue;
  border: none;
  width: 250px;
  padding: 10px 15px;
  border-radius: 3px;
  font-size: 15px;
  cursor: pointer;
  transition:
    background-color 0.25s,
    color 0.25s;
  margin-top: 10px;
}

.btn-register:hover {
  background-color: aliceblue;
  color: #adaafe;
}

.btn-login:hover {
  background-color: aliceblue;
  color: #adaafe;
}


/* 动画 */
@keyframes slide-out {
  0% {
    transform: translateX(0);
  }

  30% {
    transform: translateX(75px);
  }

  100% {
    transform: translateX(-120vw);
  }
}
</style>
