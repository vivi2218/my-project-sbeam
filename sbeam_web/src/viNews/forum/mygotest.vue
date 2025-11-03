<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted } from 'vue'
import CommentItem from '../../views/forum/CommentItem.vue' // 导入递归组件

const comments = ref([])
const newComment = ref('')

const loadComments = async () => {
  const res = await axios.get('http://localhost:8080/mygo')
  comments.value = res.data
}

const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const userId = user.userId
const userName = user.userName
console.log('当前用户', user)

const postComment = async () => {
  if (!newComment.value) return
  await axios.post('http://localhost:8080/mygo', {
    userId: userId,
    author: userName,
    content: newComment.value
  })
  newComment.value = ''
  loadComments()
}

onMounted(loadComments)
</script>

<template>
  <div>
    <h2>评论区</h2>
    <textarea v-model="newComment" placeholder="写下评论..."></textarea>
    <button @click="postComment">发表评论</button>

    <div v-for="comment in comments" :key="comment.id">
      <CommentItem :comment="comment" :reload="loadComments" />
    </div>
  </div>
</template>

<style>
textarea {
  width: 100%;
  height: 60px;
  margin: 5px 0;
}

button {
  margin: 5px;
}
</style>
