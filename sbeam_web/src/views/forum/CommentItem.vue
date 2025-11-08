<script setup lang="ts">
import { ref, PropType } from 'vue'
import axios from 'axios'

interface CommentType {
  postId: string | number
  content: string
  author: string
  replies?: CommentType[]
  id?: string | number
  timestamp?: string
}

const props = defineProps<{
  comment: CommentType
  reload: () => void
}>()

const showReply = ref(false)
const replyText = ref('')
const isSending = ref(false)

// 切换回复输入框
const toggleReply = () => {
  showReply.value = !showReply.value
  // 重置回复内容
  if (!showReply.value) {
    replyText.value = ''
  }
}

const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const userId = user.userId
const userName = user.userName
// console.log('当前用户ID:', userId)

<<<<<<< HEAD

// 发送回复
const sendReply = async () => {
  console.log(props.comment)
  if (!replyText.value) return
  if (!props.comment.postId) return  //
  console.log("post")
  await axios.post(`http://localhost:8080/mygo/${props.comment.postId}/reply`, {
    author: userName,
    content: replyText.value,
    userId: userId,
    parentPostId: props.comment.postId  // 优先使用评论id，否则用帖子id
  })
  replyText.value = ''
  showReply.value = false
  props.reload()
=======
// 获取当前社区名称
const communityName = ref('')

// 发送回复
const sendReply = async () => {
  if (!replyText.value.trim()) {
    alert('请输入回复内容')
    return
  }
  
  if (!props.comment.postId) {
    console.error('评论ID不存在')
    return
  }

  isSending.value = true
  
  try {
    // 获取当前社区名称, 如果没有，提供默认值
    const community = communityName.value || '默认社区'

    await axios.post(`http://localhost:8080/mygo/${props.comment.postId}/reply`, {
      author: userName,
      content: replyText.value,
      userId: userId,
      communityName: community,
    })

    // 成功后重置
    replyText.value = ''
    showReply.value = false
    props.reload()  // 调用父组件的 reload 方法，刷新评论
  } catch (error) {
    console.error('发送回复失败:', error)
    alert('发送回复失败，请稍后重试')
  } finally {
    isSending.value = false
  }
>>>>>>> origin/new
}
</script>

<template>
  <div class="comment-container">
    <!-- 评论头部 -->
    <div class="comment-header">
      <span class="comment-author">{{ comment.author }}</span>
      <span v-if="comment.timestamp" class="comment-time">{{ comment.timestamp }}</span>
    </div>
    
    <!-- 评论内容 -->
    <div class="comment-content">
      {{ comment.content }}
    </div>
    
    <!-- 评论操作 -->
    <div class="comment-actions">
      <button 
        class="reply-button" 
        @click="toggleReply"
        :disabled="isSending"
      >
        {{ showReply ? '取消回复' : '回复' }}
      </button>
    </div>

    <!-- 回复输入框 -->
    <div v-if="showReply" class="reply-box">
      <textarea 
        v-model="replyText" 
        placeholder="写下你的回复..."
        class="reply-input"
      ></textarea>
      <div class="reply-actions">
        <button 
          @click="sendReply" 
          class="send-reply-button"
          :disabled="isSending"
        >
          {{ isSending ? '发送中...' : '发送' }}
        </button>
      </div>
    </div>

    <!-- 递归渲染子回复 -->
    <div class="replies" v-if="comment.replies && comment.replies.length > 0">
      <CommentItem 
        v-for="reply in comment.replies" 
        :key="reply.id || reply.postId"
        :comment="reply" 
        :reload="props.reload" 
      />
    </div>
  </div>
</template>

<style scoped>
.comment-container {
  background: #252525;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 16px;
  border: 1px solid #333;
  transition: border-color 0.3s ease;
}

.comment-container:hover {
  border-color: #444;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.comment-author {
  font-weight: 600;
  color: #e0e0e0;
  font-size: 15px;
}

.comment-time {
  font-size: 12px;
  color: #777;
}

.comment-content {
  color: #ccc;
  line-height: 1.6;
  margin-bottom: 12px;
  font-size: 14px;
  word-wrap: break-word;
}

.comment-actions {
  display: flex;
  gap: 12px;
}

.reply-button {
  padding: 6px 12px;
  background: transparent;
  border: 1px solid #333;
  color: #999;
  border-radius: 4px;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.reply-button:hover {
  background: #333;
  color: #e0e0e0;
  border-color: #444;
}

.reply-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.reply-box {
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid #333;
}

.reply-input {
  width: 100%;
  min-height: 80px;
  padding: 10px;
  background: #2a2a2a;
  border: 1px solid #333;
  color: #e0e0e0;
  border-radius: 6px;
  font-size: 14px;
  font-family: inherit;
  resize: vertical;
  margin-bottom: 10px;
  transition: border-color 0.3s ease;
}

.reply-input:focus {
  outline: none;
  border-color: #444;
}

.reply-actions {
  display: flex;
  justify-content: flex-end;
}

.send-reply-button {
  padding: 8px 16px;
  background: #2a2a2a;
  border: 1px solid #333;
  color: #e0e0e0;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.send-reply-button:hover:not(:disabled) {
  background: #333;
  border-color: #444;
}

.send-reply-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* 回复嵌套样式 */
.replies {
  margin-left: 24px;
  margin-top: 12px;
}

.replies .comment-container {
  background: #2a2a2a;
  margin-bottom: 12px;
}
</style>
