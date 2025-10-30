<script setup lang="ts">

import testtingView from './viNews/test/testtingView.vue'
</script>

<template>

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
