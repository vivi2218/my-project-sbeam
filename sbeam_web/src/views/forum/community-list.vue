<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import kobeImg from '@/assets/img/kobe.png'

const BACKEND = 'http://localhost:8080'
const router = useRouter()

const communities = ref<any[]>([])

const fetchData = async () => {
  try {
    console.log('开始获取社区数据...')
    const resComm = await fetch(`${BACKEND}/community`)

    if (!resComm.ok) {
      throw new Error(`HTTP错误! 状态码: ${resComm.status}`)
    }

    const commList = await resComm.json()
    console.log('获取到社区数据:', commList)

    // 处理社区数据，只关注社区本身的信息
    communities.value = commList.map((c: any) => ({
      id: c.communityId,
      name: c.communityName,
      description: c.communityDescription,
      img: kobeImg,
      status: c.status === 0 ? '正常' : '异常',
      createdAt: new Date(c.createdAt).toLocaleDateString('zh-CN')
    }))
  } catch (err) {
    console.error('加载社区数据失败:', err)
    // 不使用模拟数据，只显示真实的后端数据
    communities.value = []
    alert('获取社区数据失败，请稍后重试')
  }
}

onMounted(fetchData)

// 点击跳转到社区详情页
const goToCommunity = (id: number) => {
  router.push({ path: `/community/${id}` })
}

// 点击跳转到帖子详情页（可选）
const goToPost = (id: number) => {
  router.push({ path: '/post-detail', query: { id } })
}
</script>

<template>
  <navigaton />

  <main class="community-main">
    <h1>社区主页</h1>

    <div class="community-list">
      <div v-for="community in communities" :key="community.id" class="community-card"
        @click="goToCommunity(community.id)">
        <!-- 社区卡片 -->
        <div class="community-header">
          <img :src="community.img" alt="社区头像" />
          <h2>{{ community.name }}</h2>
          <p>{{ community.description }}</p>
        </div>

        <!-- 社区信息 -->
        <div class="community-info">
          <div class="info-item">
            <span class="label">状态：</span>
            <span :class="['status-badge', community.status === '正常' ? 'status-normal' : 'status-abnormal']">
              {{ community.status }}
            </span>
          </div>
          <div class="info-item">
            <span class="label">创建时间：</span>
            <span class="value">{{ community.createdAt }}</span>
          </div>
        </div>

        <!-- 查看详情按钮 -->
        <div class="community-actions">
          <button class="view-detail-btn">查看详情</button>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
/* 页面整体 - 与Store页面风格一致 */
.community-main {
  position: relative;
  top: 38px;
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  padding: 20px;
  font-family: 'Microsoft YaHei', sans-serif;
  background-color: #121212;
  color: #e0e0e0;
  min-height: 100vh;
}

h1 {
  font-size: 28px;
  font-weight: 700;
  color: #e0e0e0;
  margin-bottom: 30px;
  text-align: center;
}

/* 社区列表布局 - 调整为与Store页面相似的网格布局 */
.community-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

/* 社区卡片 - 采用深色主题 */
.community-card {
  background: #1e1e1e;
  border-radius: 10px;
  overflow: hidden;
  transition: 0.3s;
  cursor: pointer;
}

.community-card:hover {
  transform: translateY(-5px);
  background: #252525;
}

/* 卡片头部 */
.community-header {
  text-align: center;
  padding: 20px 15px 10px;
  border-bottom: 1px solid #333;
}

.community-header img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 10px;
  border: 2px solid #333;
}

.community-header h2 {
  font-size: 20px;
  font-weight: 600;
  color: #e0e0e0;
  margin: 8px 0;
}

.community-header p {
  font-size: 13px;
  color: #999;
  line-height: 1.5;
  margin: 0;
}

/* 社区信息区域 */
.community-info {
  margin-top: 16px;
  padding: 0 16px;
}

.info-item {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
  font-size: 14px;
}

.info-item .label {
  color: #999;
  margin-right: 8px;
  min-width: 60px;
}

.status-badge {
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 12px;
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

.value {
  color: #e0e0e0;
}

/* 操作按钮区域 */
.community-actions {
  padding: 16px;
  margin-top: 8px;
}

.view-detail-btn {
  width: 100%;
  padding: 8px;
  background: #2a2a2a;
  color: #e0e0e0;
  border: 1px solid #333;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.view-detail-btn:hover {
  background: #333;
  border-color: #444;
}
</style>
