<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'   //  导入 useRoute
import CommentItem from '../../views/forum/CommentItem.vue'

const comments = ref([])
const newComment = ref('')

//  获取当前路由
const route = useRoute()
// 从 URL 获取 ?id=1 或 /:id 的参数
const communityId = Number(route.query.id || route.params.id)
console.log('当前社区 ID:', communityId)

// 加载评论
const loadComments = async () => {
  const res = await axios.get('http://localhost:8080/mygo', {
    params: { communityId } //  向后端传社区ID
  })
  comments.value = res.data
}

// 用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const userId = user.userId
const userName = user.userName
console.log('当前用户', user)

// 发表评论
const postComment = async () => {
  if (!newComment.value.trim()) return alert('请输入评论内容')

  await axios.post('http://localhost:8080/mygo', {
    userId,
    author: userName,
    content: newComment.value,
    communityId, //  添加 communityId
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
