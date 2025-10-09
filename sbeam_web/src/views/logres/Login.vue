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
} align-items: center;
  position: relative;
.form input:focus::placeholder {
  color: transparent;
} transition: opacity 0.5s;
}
.form input::placeholder {
  color: #b4b0b0;
  font: 14px;ne;
  font-weight: 300; #938282;
} background-color: #65637f;
  width: 250px;
.form input:hover {x;
  background-color: azure;
} margin-bottom: 10px;
  text-align: center;
.form input:focus {
  background-color: aliceblue;
  width: 300px;.25s;
  color: #adaafe;
}
.form input:focus::placeholder {
.btn-login {nsparent;
  outline: none;
  background-color: #adaafe;
  color: aliceblue;older {
  border: none;0;
  width: 250px;
  padding: 10px 15px;
  border-radius: 3px;
  font-size: 15px;
  cursor: pointer;{
  transition: 0.25s;azure;
}

.btn-login:hover {{
  background-color: aliceblue;
  color: #adaafe;
} color: #adaafe;
}
#reg {
  position: absolute;
  right: 10px;e;
  top: 10px;-color: #adaafe;
  width: 120px;lue;
  text-decoration: none;
  z-index: 10;;
} padding: 10px 15px;
  border-radius: 3px;
@keyframes slide-out {
  0% {or: pointer;
    transform: translateX(0);
  }

  30% {gin:hover {
    transform: translateX(75px);
  }olor: #adaafe;
}
  100% {
    transform: translateX(-120vw);
  }osition: absolute;
} right: 10px;
</style>0px;
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
