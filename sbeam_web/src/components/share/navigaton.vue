<template>
  <div id="navigationStyle">
    <!-- 顶部导航 -->
    <header>
      <span class="brand">
        <!-- <img src=" class="" /> -->
        <div class="logo">Sbeam</div>
      </span>
      <nav>
        <router-link to="/" class="btn-cute">首页</router-link>
        <router-link to="/store" class="btn-cute">商城</router-link>
        <router-link to="/User/car" class="btn-cute">购物车</router-link>
        <router-link to="/User/myorder" class="btn-cute">我的订单</router-link>
        <router-link to="/forum" class="btn-cute">社区</router-link>

        <a href="#" class="btn-cute" @click.prevent="goUserHome">个人中心</a>
      </nav>
    </header>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

const goUserHome = (e?: Event) => {
  if (e) e.preventDefault();
  const token = localStorage.getItem('sbeam_token');
  if (token) {
    router.push('/homeuser');
  } else {
    router.push('/login');
  }
};
</script>

<style scoped src="../../assets/Share/Navigation.css"></style>
