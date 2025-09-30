<template>
  <div class="events-page">
    <h1 class="page-title">限时活动</h1>

    <!-- 活动筛选标签 -->
    <div class="filter-tags">
      <button
        v-for="tag in tags"
        :key="tag"
        class="tag-btn"
        :class="{ active: activeTag === tag }"
        @click="activeTag = tag"
      >
        {{ tag }}
      </button>
    </div>

    <!-- 活动卡片列表 -->
    <div class="event-list">
      <div
        v-for="event in filteredEvents"
        :key="event.id"
        class="event-card"
      >
        <img :src="event.cover" alt="event" class="event-cover" />
        <div class="event-info">
          <h2>{{ event.title }}</h2>
          <p class="event-desc">{{ event.description }}</p>
          <div class="event-meta">
            <span>折扣：{{ event.discount }}%</span>
            <span>开始时间：{{ event.start }}</span>
            <span>结束时间：{{ event.end }}</span>
          </div>
          <p class="event-status" :class="getStatusClass(event)">
            状态：{{ getEventStatus(event) }}
          </p>
          <p v-if="getRemainingTime(event)" class="countdown">
            剩余时间：{{ getRemainingTime(event) }}
          </p>
          <button class="view-btn">查看详情</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue"

// 活动筛选标签
const tags = ["全部", "促销", "打折", "新品", "限时"]
const activeTag = ref("全部")

// 活动列表（死数据）
const eventList = ref([
  {
    id: 1,
    title: "国庆节促销活动",
    cover: "https://store.cloudflare.steamstatic.com/public/images/v6/home/fall_sale_2022.jpg",
    description: "国庆限时活动，海量游戏史低优惠！",
    discount: 50,
    start: "2025-09-25",
    end: "2025-10-05",
    tag: "促销",
  },
  {
    id: 2,
    title: "冒险类游戏打折周",
    cover: "https://cdn.cloudflare.steamstatic.com/steam/clusters/sale_autumn2023/6b4dd8e6c4f4a2a4ac01df7e5ed7a62f74f02bfa_1200x600.jpg",
    description: "冒险类游戏全场低至 3 折，快来探索世界！",
    discount: 70,
    start: "2025-09-20",
    end: "2025-09-30",
    tag: "打折",
  },
  {
    id: 3,
    title: "新品首发庆典",
    cover: "https://cdn.cloudflare.steamstatic.com/steam/clusters/sale_summer2024/1280x600_2.jpg",
    description: "全新游戏首发，登录即送限定奖励！",
    discount: 10,
    start: "2025-09-26",
    end: "2025-10-02",
    tag: "新品",
  },
])

// 根据标签筛选
const filteredEvents = computed(() => {
  if (activeTag.value === "全部") return eventList.value
  return eventList.value.filter((e) => e.tag === activeTag.value)
})

// 获取活动状态
function getEventStatus(event) {
  const now = new Date()
  const start = new Date(event.start)
  const end = new Date(event.end)

  if (now < start) return "未开始"
  if (now > end) return "已结束"
  return "进行中"
}

// 根据状态设置不同样式
function getStatusClass(event) {
  const status = getEventStatus(event)
  if (status === "未开始") return "upcoming"
  if (status === "进行中") return "active"
  if (status === "已结束") return "ended"
  return ""
}

// 计算剩余时间（如果活动正在进行）
function getRemainingTime(event) {
  const now = new Date()
  const end = new Date(event.end)
  const diff = end - now

  if (diff <= 0) return null
  const days = Math.floor(diff / (1000 * 60 * 60 * 24))
  const hours = Math.floor((diff / (1000 * 60 * 60)) % 24)
  return `${days}天 ${hours}小时`
}
</script>

<style scoped>
.events-page {
  background-color: #121212;
  color: #fff;
  min-height: 100vh;
  padding: 30px;
}

.page-title {
  font-size: 2.2em;
  font-weight: bold;
  margin-bottom: 20px;
  color: #00b3ff;
}

.filter-tags {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.tag-btn {
  padding: 8px 16px;
  border: none;
  background: #1f1f1f;
  color: #ccc;
  border-radius: 20px;
  cursor: pointer;
  transition: 0.3s;
}

.tag-btn:hover {
  background: #333;
  color: #fff;
}

.tag-btn.active {
  background: #00b3ff;
  color: #fff;
}

.event-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.event-card {
  background: #1c1c1c;
  border-radius: 12px;
  overflow: hidden;
  width: 380px;
  transition: 0.3s;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.6);
}

.event-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 0 15px rgba(0, 179, 255, 0.3);
}

.event-cover {
  width: 100%;
  height: 180px;
  object-fit: cover;
}

.event-info {
  padding: 15px;
}

.event-desc {
  font-size: 14px;
  color: #ccc;
  margin-bottom: 10px;
}

.event-meta {
  font-size: 13px;
  color: #aaa;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.event-status {
  margin-top: 10px;
  font-weight: bold;
}

.event-status.active {
  color: #00ff88;
}

.event-status.upcoming {
  color: #ffcc00;
}

.event-status.ended {
  color: #ff4d4f;
}

.countdown {
  color: #00b3ff;
  margin-top: 5px;
}

.view-btn {
  margin-top: 10px;
  background: #00b3ff;
  color: white;
  border: none;
  padding: 8px 12px;
  border-radius: 6px;
  cursor: pointer;
}

.view-btn:hover {
  background: #0090cc;
}
</style>
