<script setup lang="ts">
import { onMounted, onBeforeUnmount } from 'vue'

// 全局声明 YouTube API 类型
declare global {
  interface Window {
    onYouTubeIframeAPIReady: () => void
    YT: any
  }
}

const videoId = 'AcOhHbutU5o' // YouTube 视频 ID
let player: any = null

function playAudio() {
  player?.playVideo()
}

function pauseAudio() {
  player?.pauseVideo()
}

onMounted(() => {
  // 加载 YouTube IFrame API
  const tag = document.createElement('script')
  tag.src = 'https://www.youtube.com/iframe_api'
  document.body.appendChild(tag)

  // API 加载完成回调
  window.onYouTubeIframeAPIReady = () => {
    player = new window.YT.Player(document.createElement('div'), {
      height: '0', // 隐藏视频
      width: '0',
      videoId,
      playerVars: {
        autoplay: 0,
        controls: 0,
        modestbranding: 1,
        rel: 0,
      },
    })
  }
})

onBeforeUnmount(() => {
  player?.destroy()
})
</script>

<template>
  <div>
    <button @click="playAudio">播放</button>
    <button @click="pauseAudio">暂停</button>
  </div>
</template>
