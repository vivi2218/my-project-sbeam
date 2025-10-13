<script setup lang="ts">

import navigaton from './components/share/navigaton.vue';
import TestAutoIdempotent from './views/Myorder/TestAutoIdempotent.vue';


</script>

<template>


  <TestAutoIdempotent />


</template>

<style>
html,
body {
  margin: 0;
  padding: 0;
  background: linear-gradient(to top left, #1b2d39);
  min-height: 100%;
}

#app {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  min-height: 100vh;
}




.navi {
  z-index: 1;
}
</style>
