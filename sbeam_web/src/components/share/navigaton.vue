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
        <router-link to="/homeuser" class="btn-cute">个人中心</router-link>

      </nav>
    </header>
  </div>
</template>

<style scoped src="../../assets/Share/Navigation.css"></style>
