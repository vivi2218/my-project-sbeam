<script setup lang="ts">
import { ref } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const username = ref('');
const password = ref('');
const containerClass = ref('container');
const router = useRouter();

const login = async () => {
  try {
    const resp = await axios.post('http://localhost:8080/auth/login', {
      username: username.value,
      password: password.value
    });
    if (resp.data && resp.data.token) {
      const token = resp.data.token;
      localStorage.setItem('sbeam_token', token);
      axios.defaults.headers.common['Authorization'] = 'Bearer ' + token;
      containerClass.value = 'container success';
      // 跳转首页
      setTimeout(() => router.push('/'), 400);
    } else {
      alert(resp.data.msg || '登录失败');
    }
  } catch (e) {
    alert('登录请求失败');
  }
};
</script>

<template>
  <div :class="containerClass">
    <h1>Ciallo～(∠・ω< )⌒☆</h1>

        <div class="form">
          <input v-model="username" type="text" placeholder="账号" />
          <input v-model="password" type="password" placeholder="密码" />
          <button class="btn-login" @click="login">登录</button>
        </div>

        <router-link to="/register" id="reg" class="btn-login">注册</router-link>
  </div>
</template>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html,
body {
  height: 100%;
  font-family: "Segoe UI", Arial, sans-serif;
}

.container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #adaafe;
  background: linear-gradient(to top left, #013354, #444, #5a005a);
  width: 100vw;
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
  transition: background-color 0.25s, color 0.25s;
}

.btn-login:hover {
  background-color: aliceblue;
  color: #adaafe;
}

/* 注册链接样式（右上角） */
#reg {
  position: absolute;
  right: 10px;
  top: 10px;
  color: #adaafe;
  width: 120px;
  text-decoration: none;
  z-index: 10;
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
