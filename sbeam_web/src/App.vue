<script setup lang="ts">
<<<<<<< HEAD
import navigaton from './components/share/navigaton.vue'
import library from '@/views/library.vue'
import GameDetail from '@/views/GameDetail.vue'
import TestAutoIdempotent from './views/Myorder/TestAutoIdempotent.vue'
import testhome from './views/testview/testhome.vue'
import post from './views/testview/forum/post.vue'
import cart from './views/cat/cart.vue'
import Recommd from './views/recommd.vue'
</script>

<template>
  <!-- <navigaton></navigaton> -->
  <!-- <RouterView></RouterView> -->
  <!-- <testhome/> -->
  <!-- <post/> -->
  <Recommd></Recommd>
=======

import testtingView from './viNews/test/testtingView.vue'
import navigaton from './viNews/componews/navigaton.vue';
import mouz from './viNews/componews/mouz.vue'
</script>

<template>
  <mouz/>
  <navigaton />
  <RouterView />
>>>>>>> 55d98e0b50d9d1fabad299aadcec0eacff287cfe
</template>

<style>
html,
body {
  margin: 0;
  padding: 0;
  /* background: linear-gradient(to top left, #b4b4b4); */
  min-height: 100%;
}

#app {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  min-height: 100vh;
}

.navigaton {
  z-index: 1;
  position: relative;
}

html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
  overflow: hidden;
  /* 防止 body 滚动 */
  background: linear-gradient(to top left, #013354, #444, #5a005a);
  background-attachment: fixed;
}

#app {
  height: 100%;
  overflow-y: auto;
  /* 让内容区域滚动 */
}

* {
  color: rgb(140, 140, 140);
}
</style>
