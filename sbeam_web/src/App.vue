<script setup lang="ts">

import navigaton from './components/share/navigaton.vue';
import PageEssay from './components/PageEssay.vue';
import Myorder from './views/User/Myorder.vue';
import HomeView from './views/HomeView.vue';
import forumHome from './views/forum/forumHome.vue';
import forumMain from './views/forum/forumMain.vue';
import Login from './views/logres/Login.vue';
import Register from './views/logres/Register.vue';
import background from './components/share/background.vue';
import Navigaton from './components/share/navigaton.vue';
import Store from './views/Store.vue';
import gameList from '@/views/games/gameList.vue';


</script>

<template>

  <navigaton></navigaton>

  <RouterView></RouterView>
  
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
