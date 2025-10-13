
<style scoped>
/* 基础样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
}

body {
  background-color: #0A0A0F;
  color: #b3b3b3;
  font-size: 14px;
  min-height: 100vh;
  line-height: 1.5;
}

.container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 0 15px;
}

/* 头部样式 */
header {
  background-color: #121218;
  padding: 10px 0;
  border-bottom: 1px solid #2d2d44;
  position: sticky;
  top: 0;
  z-index: 10;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.brand {
  color: #3B82F6;
  font-weight: 600;
  font-size: 16px;
}

.user-area {
  display: flex;
  align-items: center;
  gap: 10px;
}

/* 纯CSS用户头像 */
.avatar {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background-color: #3B82F6;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 12px;
  font-weight: 500;
}

/* 主内容区域 */
main {
  padding: 25px 0;
}

.page-title {
  color: #ffffff;
  margin-bottom: 20px;
  font-size: 18px;
  font-weight: 600;
}

/* 状态统计卡片 */
.status-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 12px;
  margin-bottom: 25px;
}

.status-card {
  background-color: #121218;
  padding: 18px 15px;
  border-radius: 8px;
  border: 1px solid #2d2d44;
  transition: all 0.2s ease;
}

.status-card:hover {
  border-color: #3B82F6;
  transform: translateY(-2px);
}

.status-label {
  font-size: 13px;
  color: #999;
  margin-bottom: 5px;
}

.status-value {
  font-size: 22px;
  font-weight: 600;
  margin-bottom: 8px;
}

.status-desc {
  font-size: 11px;
  color: #888;
}

/* 颜色类 */
.color-blue { color: #3B82F6; }
.color-red { color: #EF4444; }
.color-purple { color: #8B5CF6; }
.color-green { color: #10B981; }

/* 筛选标签区域 */
.filters {
  margin-bottom: 25px;
}

.filter-tabs {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
  overflow-x: auto;
  padding-bottom: 5px;
  scrollbar-width: thin;
}

.filter-tabs::-webkit-scrollbar {
  height: 4px;
}

.filter-tabs::-webkit-scrollbar-thumb {
  background-color: #3B82F6;
  border-radius: 2px;
}

.filter-tab {
  padding: 6px 14px;
  background-color: #1E1E2E;
  border: none;
  border-radius: 20px;
  color: #b3b3b3;
  cursor: pointer;
  white-space: nowrap;
  font-size: 13px;
  transition: all 0.2s ease;
}

.filter-tab:hover {
  background-color: #2A2A40;
  color: #ffffff;
}

.filter-tab.active {
  background-color: #3B82F6;
  color: #ffffff;
  box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
}

/* 订单列表区域 */
.order-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.order-item {
  background-color: #121218;
  border-radius: 8px;
  border: 1px solid #2d2d44;
  overflow: hidden;
  transition: all 0.2s ease;
}

.order-item:hover {
  border-color: #3B82F6;
  box-shadow: 0 2px 10px rgba(59, 130, 246, 0.1);
}

.order-header {
  padding: 14px 15px;
  border-bottom: 1px solid #2d2d44;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 10px;
}

.order-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.order-meta {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 6px;
}

.order-status {
  padding: 3px 10px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

/* 状态背景色 */
.bg-blue { 
  background-color: rgba(59, 130, 246, 0.15); 
  color: #3B82F6;
}
.bg-green { 
  background-color: rgba(16, 185, 129, 0.15); 
  color: #10B981;
}
.bg-red { 
  background-color: rgba(239, 68, 68, 0.15); 
  color: #EF4444;
}
.bg-purple { 
  background-color: rgba(139, 92, 246, 0.15); 
  color: #8B5CF6;
}

.order-product {
  padding: 15px;
  display: flex;
  gap: 15px;
  align-items: center;
}

/* 纯CSS游戏图片 */
.product-image {
  width: 60px;
  height: 60px;
  border-radius: 6px;
  background: linear-gradient(135deg, #3B82F6 0%, #8B5CF6 100%);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 24px;
}

.product-info {
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
}

.product-id {
  font-weight: 500;
  color: #ffffff;
}

.product-meta {
  font-size: 12px;
  color: #888;
}

.product-status {
  font-size: 13px;
}

.order-actions {
  padding: 12px 15px;
  background-color: #1a1a27;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  border-top: 1px solid #2d2d44;
}

.action-button {
  padding: 6px 16px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  font-size: 12px;
  font-weight: 500;
  transition: all 0.2s ease;
}

.btn-primary {
  background-color: #3B82F6;
  color: white;
}

.btn-primary:hover {
  background-color: #2563EB;
}

.btn-secondary {
  background-color: #1E1E2E;
  color: #b3b3b3;
}

.btn-secondary:hover {
  background-color: #2A2A40;
  color: #ffffff;
}

.btn-red {
  background-color: #EF4444;
  color: white;
}

.btn-red:hover {
  background-color: #DC2626;
}

.btn-purple {
  background-color: #8B5CF6;
  color: white;
}

.btn-purple:hover {
  background-color: #7C3AED;
}

/* 分页区域 */
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 35px;
  padding-bottom: 20px;
}

.page-button {
  width: 32px;
  height: 32px;
  border-radius: 4px;
  background-color: #1E1E2E;
  border: 1px solid #2d2d44;
  color: #b3b3b3;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  transition: all 0.2s ease;
}

.page-button:hover {
  background-color: #2A2A40;
  color: #ffffff;
  border-color: #3B82F6;
}

.page-button.active {
  background-color: #3B82F6;
  color: white;
  border-color: #3B82F6;
  font-weight: 500;
}

/* 页脚样式 */
footer {
  text-align: center;
  padding: 20px 0;
  margin-top: 30px;
  font-size: 12px;
  color: #888;
  border-top: 1px solid #2d2d44;
  background-color: #121218;
}
</style>
    