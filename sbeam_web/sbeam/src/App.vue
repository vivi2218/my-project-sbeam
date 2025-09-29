<script setup lang="ts">

import navigaton from './components/share/navigaton.vue';
import PageEssay from './components/PageEssay.vue';
import Myorder from './views/User/Myorder.vue';
import HomeView from './views/HomeView.vue';
import forumHome from './views/forum/forumHome.vue';
import forumMain from './views/forum/forumMain.vue';
import Login from './views/logres/Login.vue';
import Register from './views/logres/Register.vue';


</script>

<template>
  <!-- <HomeView/> -->
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
  background-color: rgb(103, 103, 103);
  min-height: 100%;
}

#app {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  min-height: 100vh;
}


.Myorder {
  position: absolute;
  top: 60px;
}

.navi {
  z-index: 1;
}
</style>
