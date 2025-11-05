<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'  // 导入 useRoute
import CommentItem from '../../views/forum/CommentItem.vue'

const comments = ref([])
const newComment = ref('')
// 存储社区名称
const communityName = ref('')  // 声明为响应式变量

// 获取当前路由
const route = useRoute()
// 从 URL 获取 ?id=1 或 /:id 的参数
const communityId = Number(route.query.id || route.params.id)
console.log('当前社区 ID:', communityId)

// 加载评论和社区名称
const loadComments = async () => {
  try {
    // 获取社区信息
    const communityRes = await axios.get(`http://localhost:8080/community/id/${communityId}`)  // 修改为正确的路径
    const communityData = communityRes.data

    // 获取社区名称
    communityName.value = communityData.communityName
    console.log('社区名称:', communityName.value)

    // 加载评论
    const commentRes = await axios.get('http://localhost:8080/mygo', {
      params: { communityId }  // 传社区ID
    })
    comments.value = commentRes.data

  } catch (error) {
    console.error('加载评论或社区信息时发生错误:', error)
  }
}

// 用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const userId = user.userId
const userName = user.userName
console.log('当前用户', user)

// 发表评论
const postComment = async () => {
  if (!newComment.value.trim()) return alert('请输入评论内容')

  try {
    await axios.post('http://localhost:8080/mygo', {
      userId,
      author: userName,
      content: newComment.value,
      communityName: communityName.value // 添加 communityName
    })

    newComment.value = ''
    loadComments()  // 重新加载评论
  } catch (error) {
    console.error('发布评论失败:', error)
  }
}

onMounted(loadComments)
</script>

<template>
  <div>
    <h2>{{ communityName }}</h2> <!-- 显示社区名称 -->
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
