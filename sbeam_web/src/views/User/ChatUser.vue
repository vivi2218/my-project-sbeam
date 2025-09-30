<template>
  <div class="chat-page">
    <!-- 左侧用户列表 -->
    <aside class="chat-sidebar">
      <h2 class="sidebar-title">联系人</h2>
      <ul class="user-list">
        <li class="user-item active">小明</li>
        <li class="user-item">小红</li>
        <li class="user-item">管理员</li>
      </ul>
    </aside>

    <!-- 右侧聊天窗口 -->
    <section class="chat-window">
      <!-- 聊天标题 -->
      <div class="chat-header">
        <h2 class="chat-title">与 小明 的对话</h2>
      </div>

      <!-- 聊天消息 -->
      <div class="chat-messages">
        <!-- 对方消息 -->
        <div class="message-row other">
          <div class="message-bubble">你好呀！最近在玩什么游戏？</div>
        </div>

        <!-- 我的消息 -->
        <div class="message-row me">
          <div class="message-bubble">在玩艾尔登法环，太难了😂</div>
        </div>

        <!-- 对方消息 -->
        <div class="message-row other">
          <div class="message-bubble">哈哈，我也卡在boss那了。</div>
        </div>
      </div>

      <!-- 输入框 -->
      <div class="chat-input">
        <input type="text" class="input-box" placeholder="输入消息..." disabled />
        <button class="btn-send" disabled>发送</button>
      </div>
    </section>
  </div>
</template>

<style scoped>
/* 让整个页面严格填满可视区域 */
:global(html, body, #app) {
  margin: 0;
  padding: 0;
  width: 100vw;
  height: 100vh;
  background-color: #1e1e1e;
}

/* 主容器：占满可视区域 */
.chat-page {
  width: 100vw;
  height: 100vh;
  display: flex;
  background-color: #1e1e1e;
  color: #f5f5f5;
  font-family: 'Microsoft Yahei', sans-serif;
  overflow: hidden;
}

/* 左侧用户列表 */
.chat-sidebar {
  width: 220px;
  background-color: #2a2a2a;
  border-right: 2px solid #333;
  display: flex;
  flex-direction: column;
}

.sidebar-title {
  text-align: center;
  padding: 15px;
  margin: 0;
  border-bottom: 1px solid #444;
  font-size: 18px;
  color: #fff;
}

.user-list {
  list-style: none;
  margin: 0;
  padding: 0;
  flex: 1;
  overflow-y: auto;
}

.user-item {
  padding: 12px 16px;
  cursor: pointer;
  border-bottom: 1px solid #333;
}

.user-item:hover {
  background-color: #3a3a3a;
}

.user-item.active {
  background-color: #007bff;
  font-weight: bold;
  color: #fff;
}

/* 右侧聊天窗口 */
.chat-window {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.chat-header {
  padding: 15px;
  border-bottom: 1px solid #333;
  background-color: #2a2a2a;
}

.chat-title {
  margin: 0;
  font-size: 18px;
}

/* 聊天消息 */
.chat-messages {
  flex: 1;
  padding: 15px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  overflow-y: auto;
}

.message-row {
  display: flex;
  max-width: 70%;
}

.message-row.other {
  justify-content: flex-start;
}

.message-row.me {
  justify-content: flex-end;
  margin-left: auto;
}

.message-bubble {
  padding: 10px 14px;
  border-radius: 12px;
  background-color: #2a2a2a;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.4);
  font-size: 14px;
  line-height: 1.4;
}

.message-row.other .message-bubble {
  background-color: #3a3a3a;
}

.message-row.me .message-bubble {
  background-color: #007bff;
  color: #fff;
}

/* 输入框 */
.chat-input {
  display: flex;
  border-top: 1px solid #333;
  padding: 10px;
  background-color: #2a2a2a;
}

.input-box {
  flex: 1;
  padding: 10px;
  border-radius: 8px;
  border: none;
  outline: none;
  font-size: 14px;
  background-color: #1e1e1e;
  color: #fff;
}

.btn-send {
  margin-left: 10px;
  padding: 10px 16px;
  border: none;
  border-radius: 8px;
  background-color: #28a745;
  color: #fff;
  cursor: not-allowed;
  font-size: 14px;
}
</style>
