<script setup lang="ts">

import navigaton from './components/share/navigaton.vue';
import PageEssay from './components/PageEssay.vue';
import Myorder from './views/User/Myorder.vue';
</script>

<template>

  <navigaton class="navi" />
  <!-- <page-essay/> -->
  <Myorder class="Myorder" />

</template>

<style>
#app {
  display: flex;
  flex-direction: column;
  /* 纵向排列 */
  align-items: center;
  /* 横向居中 */
  min-height: 100vh;
<<<<<<< HEAD

=======
>>>>>>> 9c681b8e700af6476a35b51a64560713ed1ca80f
}

.Myorder {
  position: absolute;
<<<<<<< HEAD
  top:50px;
=======
  top: 60px;
>>>>>>> 9c681b8e700af6476a35b51a64560713ed1ca80f
}

.navi {
  z-index: 1;
}
</style>
