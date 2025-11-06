<script setup lang="ts">
import { ref, PropType } from 'vue'
import axios from 'axios'

interface CommentType {
  postId: string
  content: string
  author: string
  replies?: CommentType[]
}

const props = defineProps<{
  comment: CommentType
  reload: () => void
}>()

const showReply = ref(false)
const replyText = ref('')

// 切换回复输入框
const toggleReply = () => {
  showReply.value = !showReply.value
}

const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const userId = user.userId
const userName = user.userName

// 获取当前社区名称 (假设是从父组件或者其他地方传递过来的)
const communityName = ref('')

// 发送回复
const sendReply = async () => {
  console.log(props.comment)
  if (!replyText.value) return
  if (!props.comment.postId) return  //

  // 获取当前社区名称, 如果没有，提供默认值
  const community = communityName.value || '默认社区'

  await axios.post(`http://localhost:8080/mygo/${props.comment.postId}/reply`, {
    author: userName,
    content: replyText.value,
    userId: userId,
    communityName: community,  // 这里传递 communityName
  })

  replyText.value = ''
  showReply.value = false
  props.reload()  // 调用父组件的 reload 方法，刷新评论
}
</script>

<template>
  <div class="comment">
    <p><b>{{ comment.author }}</b>: {{ comment.content }}</p>
    <button @click="toggleReply">回复</button>

    <div v-if="showReply" class="reply-box">
      <input v-model="replyText" placeholder="回复内容..." />
      <button @click="sendReply">发送</button>
    </div>

    <!-- 递归渲染子回复 -->
    <div class="replies" v-if="comment.replies && comment.replies.length">
      <CommentItem v-for="reply in comment.replies" :key="reply.id" :comment="reply" :reload="props.reload" />
    </div>
  </div>
</template>

<style scoped>
.comment {
  margin: 10px 0;
  padding: 10px;
  border: 1px solid #ccc;
}

.replies {
  margin-left: 20px;
}

.reply-box {
  margin-top: 5px;
}
</style>
