<template>
  <div class="orders">
    <h1 class="page-title">我的订单</h1>
    
    <div class="order-filters">
      <button class="filter-btn" :class="{ 'active': activeFilter === 'all' }" @click="activeFilter = 'all'">全部订单</button>
      <button class="filter-btn" :class="{ 'active': activeFilter === 'pending' }" @click="activeFilter = 'pending'">待支付</button>
      <button class="filter-btn" :class="{ 'active': activeFilter === 'canceled' }" @click="activeFilter = 'canceled'">已取消</button>
      <button class="filter-btn" :class="{ 'active': activeFilter === 'review' }" @click="activeFilter = 'review'">待点评</button>
      <button class="filter-btn" :class="{ 'active': activeFilter === 'completed' }" @click="activeFilter = 'completed'">已完成</button>
    </div>

    <div class="order-list">
      <div class="order-item" v-for="order in filteredOrders" :key="order.id" :data-status="order.status">
        <div class="order-details">
          <div class="order-title">{{ order.gameTitle }}</div>
          <div class="order-meta">订单号: {{ order.orderNumber }} | 购买日期: {{ order.date }} | 金额: {{ order.amount }}</div>
        </div>
        <div class="order-status" :class="'status-' + order.status">
          {{ orderStatusText(order.status) }}
        </div>
        <div class="order-actions">
          <button class="action-btn cancel-btn" v-if="order.status === 'pending'" @click="cancelOrder(order.id)">取消订单</button>
          <button class="action-btn delete-btn" v-if="order.status !== 'pending'" @click="deleteOrder(order.id)">删除订单</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeFilter: 'all',
      orders: [
        { 
          id: 1, 
          gameTitle: '赛博朋克 2077', 
          orderNumber: '#123456', 
          date: '2023-05-15', 
          amount: '¥298.00', 
          status: 'pending' 
        },
        { 
          id: 2, 
          gameTitle: '反恐精英：全球攻势', 
          orderNumber: '#123450', 
          date: '2023-04-22', 
          amount: '¥116.00', 
          status: 'completed' 
        },
        { 
          id: 3, 
          gameTitle: 'DOTA 2', 
          orderNumber: '#123445', 
          date: '2023-03-10', 
          amount: '¥0.00', 
          status: 'review' 
        },
        { 
          id: 4, 
          gameTitle: '巫师 3：狂猎', 
          orderNumber: '#123430', 
          date: '2023-02-18', 
          amount: '¥158.00', 
          status: 'canceled' 
        }
      ]
    }
  },
  computed: {
    filteredOrders() {
      if (this.activeFilter === 'all') return this.orders;
      return this.orders.filter(order => order.status === this.activeFilter);
    }
  },
  methods: {
    cancelOrder(orderId) {
      if (confirm('确定要取消这个订单吗？')) {
        const order = this.orders.find(o => o.id === orderId);
        if (order) {
          order.status = 'canceled';
        }
      }
    },
    deleteOrder(orderId) {
      if (confirm('确定要删除这个订单吗？删除后无法恢复。')) {
        this.orders = this.orders.filter(o => o.id !== orderId);
      }
    },
    orderStatusText(status) {
      const statusMap = {
        'pending': '待支付',
        'canceled': '已取消',
        'review': '待点评',
        'completed': '已完成'
      };
      return statusMap[status] || status;
    }
  },
  mounted() {
    const savedOrders = localStorage.getItem('steamOrders');
    if (savedOrders) {
      this.orders = JSON.parse(savedOrders);
    }
  },
  watch: {
    orders: {
      deep: true,
      handler(newOrders) {
        localStorage.setItem('steamOrders', JSON.stringify(newOrders));
      }
    }
  }
}
</script>
