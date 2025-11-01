<script setup lang="ts">

</script>
<template>
  <div class="navigation">
    <div class="nav-left">
      <router-link to="/" class="rout">logo</router-link>
      <router-link to="/" class="rout">商城</router-link>
      <router-link to="/" class="rout">仓库</router-link>
      <router-link to="/" class="rout">社区</router-link>
    </div>
    <div class="nav-right">
      <router-link to="/" class="rout">消息</router-link>
      <router-link to="/" class="rout">个人中心</router-link>
    </div>
  </div>
</template>

<style>
.navigation {
  display: flex;
  /* 开启 flex 布局 */
  justify-content: space-between;
  /* 左右两端对齐 */
  align-items: center;
  /* 垂直居中 */
  width: 100%;
  height: 70px;
  background-color: rgba(0, 0, 0, 0.626);
  /* 左右内边距 */
  color: #fff;
}

.nav-left,
.nav-right {
  display: flex;
  /* 子元素水平排列 */
  align-items: center;
}

.nav-left {
  padding-left: 10px;
}

.nav-right {
  padding-right: 40px;
}


.rout {
  padding: 0 15px;
  /* 调整每个链接间距 */
  text-decoration: none;
  color: #fff;
  outline: none;
  /* 去掉默认轮廓线 */
}

.rout:hover {
  color: #adaafe;
  /* 悬停效果 */
}
</style>
