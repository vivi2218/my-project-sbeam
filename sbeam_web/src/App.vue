<script setup lang="ts">

import navigaton from './components/share/navigaton.vue';
import library from '@/views/library.vue';
import GameDetail from '@/views/GameDetail.vue';
import Orders from '@/views/Orders.vue';
import ConfirmOrder from '@/views/Myorder/ConfirmOrder.vue';

</script>

<template>
<!-- <ConfirmOrder /> -->
  <div id="app">
    <div class="navi">
      <navigaton />
    </div>
    <router-view />
  </div>


</template>

<style>
html,
body {
  margin: 0;
  padding: 0;
  background: linear-gradient(to top left, #e2eff9);
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
