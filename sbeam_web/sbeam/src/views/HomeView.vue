  <script setup lang="ts">
  import { ref, onMounted, onUnmounted } from 'vue';
  import navigaton from '@/components/share/navigaton.vue';

  const subTop = ref(60); // 初始 top 60px

  const handleScroll = () => {
    const scrollY = window.scrollY;
    // 当滚动超过 60px，就把 top 设置为 0
    subTop.value = scrollY >= 60 ? 0 : 60 - scrollY;
  };

  onMounted(() => {
    window.addEventListener('scroll', handleScroll);
  });

  onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
  });
  </script>

  <template>
    <main>
      <div class="top">
        <navigaton />
      </div>
      <div class="main">
        <div class="game">推荐</div>
        <div class="game">今日特卖</div>
        <div class="game">探索</div>
      </div>
      <div class="sub" :style="{ top: subTop + 'px' }">
        <div class="comm">热门社区</div>
        <div class="tieba">热门帖子</div>
      </div>

    </main>
  </template>

  <style>
  main {
    height: 100%;
    /* 或直接 height: 100%; */
    width: 100%;
    /* background-color: aquamarine; */
  }

  .main {
    background-color: aqua;
    width: 1000px;

    padding: 10px;

  }

  .game {
    background-color: deeppink;
    height: 300px;
    margin: 10px;
  }

  .sub {
    background-color: rgb(141, 244, 39);
    top: 60px;
    position: fixed;
    right: 70px;
    width: 400px;
    height: 800px;
    z-index: 1;
  }
  </style>
