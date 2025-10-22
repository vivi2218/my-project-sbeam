<script setup lang="ts">
import { ref } from 'vue';

const username = ref('');
const password = ref('');
const phone = ref('');
const code = ref('');

const sendCode = () => {
  console.log('发送验证码到', phone.value);
};

const register = () => {
  console.log('注册信息:', username.value, password.value, phone.value, code.value);
  //localhost:8080/user
  fetch('http://localhost:8080/user', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      name: username.value,
      password: password.value,
      phone: phone.value,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      console.log('注册成功:', data);
    })
    .catch((error) => {
      console.error('注册失败:', error);
    });
};
</script>

<template>
  <div class="container">
    <div id="logo">
      <img src="@/assets/img/Sbeam.png" alt="logo" />
      sbeam
    </div>

    <div class="form">
      <input v-model="username" type="text" placeholder="账号" />
      <input v-model="password" type="password" placeholder="密码" />

      <div class="phone">
        <input v-model="phone" type="text" placeholder="手机号" />
        <button class="btn-login" @click="sendCode">获取</button>
      </div>

      <input v-model="code" type="text" placeholder="验证码" />

      <router-link to="/login" class="btn-login" @click="register">注册</router-link>
    </div>
  </div>
</template>

<style scoped>
/* App.vue 或 main.css */
html,
body,
#app {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  /* 关键：高度100% */
}

.container{
  width: 100vw;
}

body {
  font-family: "Segoe UI", Arial, sans-serif;
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
