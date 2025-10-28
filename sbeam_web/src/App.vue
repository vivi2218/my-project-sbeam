<script setup lang="ts">
import navigaton from './components/share/navigaton.vue'
import library from '@/views/library.vue'
import GameDetail from '@/views/GameDetail.vue'
import TestAutoIdempotent from './views/Myorder/TestAutoIdempotent.vue'
import testhome from './views/testview/testhome.vue'
import post from './views/testview/forum/post.vue'
import cart from './views/User/cart.vue'
import testtingView from './viNews/test/testtingView.vue'
</script>

<template>
  <!-- <navigaton></navigaton> -->
  <!-- <RouterView></RouterView> -->
  <!-- <testhome/> -->
  <!-- <post/> -->
  <testtingView/>
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
</style>
