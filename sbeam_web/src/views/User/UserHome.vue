<script setup lang="ts">
import axios from 'axios'

async function logout() {
  try {
    // 通知后端清除服务端会话
    await axios.post('http://localhost:8080/auth/logout')

    // 清除本地存储的用户信息和 token
    localStorage.removeItem('sbeam_token')
    localStorage.removeItem('sbeam_user')

    console.log('用户已退出登录')

    // 跳转回登录页
    window.location.href = '/login'
  } catch (error) {
    console.error('登出失败：', error)
    localStorage.removeItem('sbeam_token')
    localStorage.removeItem('sbeam_user')
    window.location.href = '/login'
  }
}
</script>

<template>
  <div class="UserHome">
    <div class="container">
      <!-- 左侧栏 -->
      <aside class="sidebar">
        <div class="profile">
          <img src="/user/harusekai.png" alt="用户头像" />
          <h2>玩家昵称</h2>
          <p>Lv.15 玩家</p>
        </div>
        <div class="menu">
          <a href="#">我的游戏库</a>
          <a href="#">愿望单</a>
          <a href="#">订单记录</a>
          <a href="#">账号设置</a>
        </div>
      </aside>

      <!-- 右侧内容 -->
      <main class="content">
        <div class="card">
          <h3>已购买的游戏</h3>
          <div class="games">
            <div class="game">
              <img src="/gameimg/1.jpg" alt="游戏封面" />
              <p>游戏名称 1</p>
            </div>
            <div class="game">
              <img src="/gameimg/2.jpg" alt="游戏封面" />
              <p>游戏名称 2</p>
            </div>
            <div class="game">
              <img src="/gameimg/3.jpg" alt="游戏封面" />
              <p>游戏名称 3</p>
            </div>
          </div>
        </div>

        <div class="card">
          <h3>我的愿望单</h3>
          <div class="games">
            <div class="game">
              <img src="/gameimg/4.jpg" alt="游戏封面" />
              <p>心愿游戏 1</p>
            </div>
            <div class="game">
              <img src="/gameimg/5.jpg" alt="游戏封面" />
              <p>心愿游戏 2</p>
            </div>
          </div>
        </div>


        <button class="logout-button" @click="logout">退出登录</button>
      </main>
    </div>
  </div>
</template>

<style src="../../assets/User/UserHome.css"></style>
