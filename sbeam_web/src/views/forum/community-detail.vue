<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'

import kobeImg from '@/assets/img/kobe.png'

// 数据状态
const posts = ref([])
const newPostTitle = ref('')
const newPostContent = ref('')
const communityName = ref('')
const communityDescription = ref('')
const communityStatus = ref('')
const communityCreatedAt = ref('')
const isLoading = ref(true)
const errorMessage = ref('')
const isPosting = ref(false)
const showPostForm = ref(false)

const route = useRoute()
const router = useRouter()
const communityId = Number(route.query.id || route.params.id)

// 加载社区信息和帖子列表
const loadCommunityData = async () => {
  isLoading.value = true
  errorMessage.value = ''

  try {
    // 获取社区信息
    const communityRes = await axios.get(`http://localhost:8080/community/id/${communityId}`)
    const communityData = communityRes.data

    communityName.value = communityData.communityName
    communityDescription.value = communityData.communityDescription
    communityStatus.value = communityData.status === 0 ? '正常' : '异常'
    communityCreatedAt.value = new Date(communityData.createdAt).toLocaleDateString('zh-CN')

    // 加载帖子列表
    const postsRes = await axios.get('http://localhost:8080/mygo', {
      params: { communityId }
    })

    // 处理帖子数据
    posts.value = (postsRes.data || []).map((post: any) => ({
      id: post.postId || post.id,
      title: post.postTitle || '无标题',
      content: post.postContent || post.content || '',
      author: post.author || post.userName || '匿名',
      createdAt: post.createdAt ? new Date(post.createdAt).toLocaleString() : '',
      likeCount: post.likeCount || 0,
      commentCount: post.commentCount || 0,
      userId: post.userId
    }))

  } catch (error) {
    console.error('加载社区数据时发生错误:', error)
    errorMessage.value = '加载社区数据失败，请稍后重试'
  } finally {
    isLoading.value = false
  }
}

// 用户信息
const user = JSON.parse(localStorage.getItem('sbeam_user') || '{}')
const userId = user.userId
const userName = user.userName

// 返回社区列表
const goBack = () => {
  router.push('/forum')
}

// 切换发帖表单显示
const togglePostForm = () => {
  showPostForm.value = !showPostForm.value
  if (!showPostForm.value) {
    newPostTitle.value = ''
    newPostContent.value = ''
  }
}

// 发表帖子
const createPost = async () => {
  if (!newPostTitle.value.trim()) {
    alert('请输入帖子标题')
    return
  }

  if (!newPostContent.value.trim()) {
    alert('请输入帖子内容')
    return
  }

  isPosting.value = true

  try {
    const response = await axios.post('http://localhost:8080/mygo', {
      userId,
      userName,
      postTitle: newPostTitle.value.trim(),
      postContent: newPostContent.value.trim(),
      communityId,
      communityName: communityName.value,
      createdAt: new Date().toISOString(),
      likeCount: 0,
      status: 'active'
    })

    // 重置表单
    newPostTitle.value = ''
    newPostContent.value = ''
    showPostForm.value = false

    // 重新加载数据
    loadCommunityData()

  } catch (error) {
    console.error('发布帖子失败:', error)
    alert('发布帖子失败，请稍后重试')
  } finally {
    isPosting.value = false
  }
}

// 跳转到帖子详情页
const goToPostDetail = (postId: string | number) => {
  router.push({ path: '/post-detail', query: { id: postId } })
}

onMounted(loadCommunityData)
</script>

<template>
  <navigaton />

  <main class="community-detail">
    <!-- 加载状态 -->
    <div v-if="isLoading" class="loading">
      <p>加载中...</p>
    </div>

    <!-- 错误提示 -->
    <div v-else-if="errorMessage" class="error-message">
      {{ errorMessage }}
      <button @click="loadCommunityData">重试</button>
    </div>

    <!-- 社区详情内容 -->
    <div v-else class="content">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回社区列表</button>

      <!-- 社区信息卡片 -->
      <div class="community-card">
        <div class="community-header">
          <img :src="kobeImg" alt="社区头像" class="community-avatar" />
          <div class="community-info">
            <h1 class="community-title">{{ communityName }}</h1>
            <p class="community-desc">{{ communityDescription }}</p>
            <div class="community-meta">
              <span :class="['status-badge', communityStatus === '正常' ? 'status-normal' : 'status-abnormal']">
                {{ communityStatus }}
              </span>
              <span class="created-date">创建于: {{ communityCreatedAt }}</span>
            </div>
          </div>
        </div>
      </div>



      <!-- 发帖按钮 -->
      <button class="create-post-btn" @click="togglePostForm">
        {{ showPostForm ? '取消发帖' : '发表新帖' }}
      </button>

      <!-- 发帖表单 -->
      <section v-if="showPostForm" class="post-form-section">
        <h2 class="section-title">发表新帖</h2>
        <div class="post-form">
          <input
            v-model="newPostTitle"
            type="text"
            placeholder="请输入帖子标题..."
            class="post-title-input"
          />
          <textarea
            v-model="newPostContent"
            placeholder="分享你的想法..."
            class="post-content-input"
          ></textarea>
          <button
            @click="createPost"
            class="submit-post-btn"
            :disabled="isPosting"
          >
            {{ isPosting ? '发布中...' : '发布帖子' }}
          </button>
        </div>
      </section>

        <!-- 帖子列表 -->
        <section class="posts-section">
          <h2 class="section-title">社区讨论 ({{ posts.length }})</h2>

          <div v-if="posts.length === 0" class="no-posts">
            <p>暂无讨论内容</p>
          </div>

          <div v-else class="posts-list">
            <div
              v-for="post in posts"
              :key="post.id"
              class="post-item"
              @click="goToPostDetail(post.id)"
            >
              <h3 class="post-title">{{ post.title }}</h3>
              <p class="post-content">{{ post.content }}</p>
              <div class="post-meta">
                <span class="post-author">{{ post.author }}</span>
                <span class="post-date">{{ post.createdAt }}</span>
                <div class="post-stats">
                  <span class="post-stat">{{ post.likeCount }} 赞</span>
                  <span class="post-stat">{{ post.commentCount }} 评论</span>
                </div>
              </div>
            </div>
          </div>
        </section>
    </div>
  </main>
</template>

<style scoped>
/* 页面整体布局 */
.community-detail {
  position: relative;

  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  padding: 20px;
  font-family: 'Microsoft YaHei', sans-serif;
  background-color: #121212;
  color: #e0e0e0;
  min-height: 100vh;
}

/* 加载和错误状态 */
.loading, .error-message {
  text-align: center;
  padding: 40px;
  color: #999;
}

.error-message button {
  margin-top: 10px;
  padding: 8px 16px;
  background: #2a2a2a;
  border: 1px solid #333;
  color: #e0e0e0;
  border-radius: 6px;
  cursor: pointer;
}

/* 返回按钮 */
.back-button {
  padding: 8px 16px;
  background: #2a2a2a;
  border: 1px solid #333;
  color: #e0e0e0;
  border-radius: 6px;
  cursor: pointer;
  margin-bottom: 20px;
  transition: all 0.3s ease;
}

.back-button:hover {
  background: #333;
  border-color: #444;
}

/* 社区信息卡片 */
.community-card {
  background: #1e1e1e;
  border-radius: 10px;
  padding: 20px;
  margin-bottom: 30px;
  border: 1px solid #333;
}

.community-header {
  display: flex;
  align-items: flex-start;
  gap: 20px;
}

.community-avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  border: 2px solid #333;
  object-fit: cover;
}

.community-info {
  flex: 1;
}

.community-title {
  font-size: 28px;
  font-weight: 700;
  color: #e0e0e0;
  margin: 0 0 10px 0;
}

.community-desc {
  font-size: 16px;
  color: #999;
  margin: 0 0 15px 0;
  line-height: 1.6;
}

.community-meta {
  display: flex;
  align-items: center;
  gap: 15px;
  flex-wrap: wrap;
}

.status-badge {
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 13px;
  font-weight: 500;
}

.status-normal {
  background-color: rgba(0, 150, 136, 0.2);
  color: #009688;
}

.status-abnormal {
  background-color: rgba(255, 77, 79, 0.2);
  color: #ff4d4f;
}

.created-date {
  font-size: 14px;
  color: #777;
}

/* 发帖按钮 */
.create-post-btn {
  margin: 20px 0;
  padding: 12px 24px;
  background: #009688;
  border: none;
  color: white;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
}

.create-post-btn:hover {
  background: #00796b;
  transform: translateY(-1px);
}

/* 发帖表单区域 */
.post-form-section {
  background: #1e1e1e;
  border-radius: 10px;
  padding: 20px;
  border: 1px solid #333;
  margin-bottom: 30px;
}

.post-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.post-title-input {
  width: 100%;
  padding: 12px;
  background: #2a2a2a;
  border: 1px solid #333;
  color: #e0e0e0;
  border-radius: 6px;
  font-size: 16px;
  font-family: inherit;
  transition: border-color 0.3s ease;
}

.post-title-input:focus {
  outline: none;
  border-color: #444;
}

.post-content-input {
  width: 100%;
  min-height: 200px;
  padding: 12px;
  background: #2a2a2a;
  border: 1px solid #333;
  color: #e0e0e0;
  border-radius: 6px;
  font-size: 14px;
  font-family: inherit;
  resize: vertical;
  transition: border-color 0.3s ease;
}

.post-content-input:focus {
  outline: none;
  border-color: #444;
}

.submit-post-btn {
  padding: 12px 24px;
  background: #009688;
  border: none;
  color: white;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  align-self: flex-start;
}

.submit-post-btn:hover:not(:disabled) {
  background: #00796b;
  transform: translateY(-1px);
}

.submit-post-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

/* 帖子列表区域 */
.posts-section {
  background: #1e1e1e;
  border-radius: 10px;
  padding: 20px;
  border: 1px solid #333;
}

.section-title {
  font-size: 24px;
  font-weight: 600;
  color: #e0e0e0;
  margin: 0 0 20px 0;
  border-bottom: 1px solid #333;
  padding-bottom: 10px;
}

/* 帖子列表 */
.posts-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.no-posts {
  text-align: center;
  padding: 60px;
  color: #777;
  font-style: italic;
  font-size: 16px;
}

/* 帖子卡片 */
.post-card {
  background: #252525;
  border-radius: 8px;
  padding: 16px;
  border: 1px solid #333;
  cursor: pointer;
  transition: all 0.3s ease;
}

.post-card:hover {
  background: #2a2a2a;
  border-color: #444;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.post-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
}

.post-title {
  font-size: 18px;
  font-weight: 600;
  color: #e0e0e0;
  margin: 0;
  flex: 1;
  margin-right: 16px;
}

.post-time {
  font-size: 12px;
  color: #777;
  white-space: nowrap;
}

.post-content-preview {
  color: #ccc;
  line-height: 1.6;
  margin-bottom: 16px;
  font-size: 14px;
  word-wrap: break-word;
}

.post-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.post-author {
  font-size: 13px;
  color: #999;
}

.post-stats {
  display: flex;
  gap: 20px;
  font-size: 13px;
  color: #999;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 4px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .post-header {
    flex-direction: column;
    gap: 8px;
  }

  .post-time {
    align-self: flex-start;
  }

  .post-footer {
    flex-direction: column;
    gap: 8px;
    align-items: flex-start;
  }
}
</style>
