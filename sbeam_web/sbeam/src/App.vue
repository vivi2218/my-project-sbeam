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


</script>

<template>
  <!-- <background /> -->
  <HomeView/>
  <!-- <forum-home/> -->
  <!-- <forum-main/> -->
  <!-- <login/> -->
  <!-- <Register /> -->


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
