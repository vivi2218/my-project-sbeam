<script setup lang="ts">
import { ref } from 'vue';

// 定义用户信息表单数据
const userInfo = ref({
  username: '',
  email: '',
  phoneNumber: '',
  address: ''
});

// 表单提交处理
const handleSubmit = () => {

  alert('用户信息已保存');
};
</script>

<template>
  <div class="user-info-container">
    <h2>用户信息管理</h2>
    <form @submit.prevent="handleSubmit" class="info-form">
      <div class="form-group">
        <label>用户名:</label>
        <input
          v-model="userInfo.username"
          type="text"
          required
          placeholder="请输入用户名"
        />
      </div>

      <div class="form-group">
        <label>邮箱:</label>
        <input
          v-model="userInfo.email"
          type="email"
          required
          placeholder="请输入邮箱"
        />
      </div>

      <div class="form-group">
        <label>手机号:</label>
        <input
          v-model="userInfo.phoneNumber"
          type="tel"
          placeholder="请输入手机号"
        />
      </div>

      <div class="form-group">
        <label>地址:</label>
        <textarea
          v-model="userInfo.address"
          placeholder="请输入地址"
          rows="3"
        ></textarea>
      </div>

      <button type="submit" class="submit-btn">保存信息</button>
    </form>
  </div>
</template>

<style scoped>
.user-info-container {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  border-radius: 8px;
}

.info-form .form-group {
  margin-bottom: 15px;
}

.info-form label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

.info-form input, .info-form textarea {
  width: 100%;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.submit-btn {
  background-color: #42b983;
  color: white;
  border: none;
  padding: 10px 15px;
  border-radius: 4px;
  cursor: pointer;
}

.submit-btn:hover {
  background-color: #359469;
}
</style>
