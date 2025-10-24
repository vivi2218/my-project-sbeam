<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const handleClick = () => {
  // 跳转到 /forum/post 页面
  router.push('../forum/post');
}
</script>

<template>
  <div>
    <button @click="handleClick">post测试</button>
  </div>
</template>
