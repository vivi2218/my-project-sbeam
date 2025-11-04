<script setup lang="ts">

import testtingView from './viNews/test/testtingView.vue'
import navigaton from './viNews/componews/navigaton.vue';
</script>

<template>
  <navigaton />
  <RouterView />
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
