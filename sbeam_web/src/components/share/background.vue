<script setup lang="ts">
import { onMounted } from 'vue';

/** 让单个 li 方块开始随机动画 */
function animateSquare(li: HTMLLIElement) {
  function startAnimation() {
    li.style.left = Math.random() * 100 + '%';

    const size = Math.random() * 70 + 10;
    li.style.width = size + 'px';
    li.style.height = size + 'px';

    li.style.backgroundColor = `rgba(240,255,255,${Math.random() * 0.5})`;

    const minSize = 10, maxSize = 80;
    const minDuration = 2, maxDuration = 15;
    const normalizedSize = (size - minSize) / (maxSize - minSize);
    const duration = minDuration + Math.pow(normalizedSize, 2) * (maxDuration - minDuration);

    // 重新触发动画
    li.style.animation = 'none';
    li.offsetHeight; // 强制重绘
    li.style.animation = `square ${duration}s linear forwards`;

    li.addEventListener('animationend', function handler() {
      li.removeEventListener('animationend', handler);
      startAnimation();
    });
  }
  startAnimation();
}

onMounted(() => {
  const bgSquares = document.createElement('ul');
  bgSquares.classList.add('bg-squares');
  document.body.appendChild(bgSquares);

  // 初始方块
  const initialCount = 12;
  for (let i = 0; i < initialCount; i++) {
    const li = document.createElement('li');
    bgSquares.appendChild(li);
    animateSquare(li);
  }

  // 点击生成方块
  document.addEventListener('click', (e) => {
    const newLi = document.createElement('li');
    bgSquares.appendChild(newLi);

    const size = Math.random() * 70 + 10;
    newLi.style.width = size + 'px';
    newLi.style.height = size + 'px';
    newLi.style.left = e.clientX - size / 2 + 'px';
    newLi.style.top = e.clientY - size / 2 + 'px';
    newLi.style.backgroundColor = `rgba(240,255,255,${Math.random() * 0.5})`;

    const minDuration = 2, maxDuration = 8;
    const duration = minDuration + Math.random() * (maxDuration - minDuration);
    newLi.style.animation = `square ${duration}s linear forwards`;

    newLi.addEventListener('animationend', () => {
      // 如果想动画后删除，可解开：
      // newLi.remove();
    });
  });
});
</script>

<template>
  <!-- 组件本身只渲染一个容器（也可以什么都不渲染）-->
  <div class="background-wrapper"></div>
</template>

<style scoped>
/* 组件背景容器可选 */
.background-wrapper {
  position: fixed;
  inset: 0;
  z-index: -1; /* 放到最底层 */
}

/* 全局方块样式 */
.bg-squares {
  position: fixed;
  inset: 0;
  overflow: hidden;
}

.bg-squares li {
  list-style: none;
  width: 40px;
  height: 40px;
  background-color: rgba(240, 255, 255, 0.25);
  position: absolute;
  bottom: -160px;
  animation: square linear forwards;
  transform: translateX(var(--translateX, 0)) translateY(100vh);
}

@keyframes square {
  0% {
    transform: translateX(var(--translateX, 0)) translateY(0) rotate(0deg);
  }
  100% {
    transform: translateX(var(--translateX, 0)) translateY(-150vh) rotate(600deg);
  }
}
</style>
