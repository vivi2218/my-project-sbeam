<template>
  <!-- 头部导航 -->
  <header>
    <div class="container">
      <div class="header-content">
        <div class="brand">游戏订单管理</div>
        <div class="user-area">
          <!-- 纯CSS头像（显示用户首字母） -->
          <div class="avatar">U</div>
          <span>游戏用户</span>
        </div>
      </div>
    </div>
  </header>

  <!-- 主内容区域 -->
  <main>
    <div class="container">
      <h2 class="page-title">我的订单</h2>
      
      <!-- 订单状态统计卡片 -->
      <div class="status-cards">
        <div class="status-card">
          <div class="status-label">待支付</div>
          <div class="status-value color-blue">5</div>
          <div class="status-desc">根据myorder表统计</div>
        </div>
        <div class="status-card">
          <div class="status-label">已取消</div>
          <div class="status-value color-red">0</div>
          <div class="status-desc">无相关数据</div>
        </div>
        <div class="status-card">
          <div class="status-label">待点评</div>
          <div class="status-value color-purple">15</div>
          <div class="status-desc">已支付订单总数</div>
        </div>
        <div class="status-card">
          <div class="status-label">已完成</div>
          <div class="status-value color-green">15</div>
          <div class="status-desc">已支付订单总数</div>
        </div>
      </div>
      
      <!-- 订单筛选标签 -->
      <div class="filters">
        <div class="filter-tabs">
          <button class="filter-tab active">全部订单</button>
          <button class="filter-tab">待支付</button>
          <button class="filter-tab">已取消</button>
          <button class="filter-tab">待点评</button>
          <button class="filter-tab">已完成</button>
        </div>
      </div>
      
      <!-- 订单列表 -->
      <div class="order-list">
        <div class="order-item" data-status="completed">
          <div class="order-header">
            <div class="order-info">
              <div>订单号: ORD20210101</div>
              <div>下单时间: 2021-01-01 10:00:00</div>
            </div>
            <div class="order-meta">
              <div class="order-status bg-green">已完成</div>
              <div>实付: ¥47.99</div>
            </div>
          </div>
          
          <div class="order-product">
            <!-- 纯CSS游戏图标 -->
            <div class="product-image">🎮</div>
            <div class="product-info">
              <div class="product-id">游戏ID: GAME001</div>
              <div class="product-meta">
                订单详情ID: 1 | 用户ID: 1 | 优惠ID: 1
              </div>
              <div class="product-status">购买状态: 已支付</div>
            </div>
          </div>
          
          <div class="order-actions">
            <button class="action-button btn-secondary">查看详情</button>
            <button class="action-button btn-purple">去点评</button>
          </div>
        </div>
      </div>
      
      <!-- 分页控件 -->
      <div class="pagination">
        <button class="page-button active">1</button>
        <button class="page-button">2</button>
        <button class="page-button">3</button>
        <button class="page-button">4</button>
      </div>
    </div>
  </main>

  <!-- 页脚 -->
  <footer>
    <div class="container">
      © 2023 游戏订单管理系统 | 保留所有权利
    </div>
  </footer>
</template>

