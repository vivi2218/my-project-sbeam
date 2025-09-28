<script setup lang="ts">

import navigaton from './components/share/navigaton.vue';
import PageEssay from './components/PageEssay.vue';
import Myorder from './views/User/Myorder.vue';
import HomeView from './views/HomeView.vue';


</script>

<template>
  <HomeView></HomeView>


</template>

<style>

#app {
  display: flex;
  flex-direction: column;
  /* 纵向排列 */
  align-items: center;
  /* 横向居中 */
  min-height: 100vh;
  min-width: 100vw;
  background-color:blanchedalmond;
}

.Myorder {
  position: absolute;
  top: 60px;
}

.navi {
  z-index: 1;
}
</style>
