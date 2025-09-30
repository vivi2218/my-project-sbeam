<script setup lang="ts">
import { ref } from 'vue';

const username = ref('');
const password = ref('');
const containerClass = ref('container');

const login = () => {
  containerClass.value = 'container success';
  console.log('账号:', username.value, '密码:', password.value);
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
  margin: 0;
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
  overflow: hidden;
}

.container {
  width: 100vw;
}


.container.success h1 {
  animation: slide-out 2s ease-in-out forwards;
}

.container.success .form {
  opacity: 0;
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
  z-index: 2;
  opacity: 1;
  transition: opacity 0.5s;
}

.form input {
  outline: none;
  border: 1px solid #938282;
  background-color: #65637f;
  width: 250px;
  padding: 10px 15px;
  border-radius: 3px;
  margin-bottom: 10px;
  text-align: center;
  color: #b9abff;
  font-size: 15px;
  transition: 0.25s;
}

.form input:focus::placeholder {
  color: transparent;
}

.form input::placeholder {
  color: #b4b0b0;
  font: 14px;
  font-weight: 300;
}

.form input:hover {
  background-color: azure;
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
  transition: 0.25s;
}

.btn-login:hover {
  background-color: aliceblue;
  color: #adaafe;
}

#reg {
  position: absolute;
  right: 10px;
  top: 10px;
  width: 120px;
  text-decoration: none;
  z-index: 10;
}

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
