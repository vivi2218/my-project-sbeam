<template>
  <div class="UserHome">
    <div class="container">
      <!-- 左侧栏 -->
      <aside class="sidebar">
        <div class="profile">
          <img src="https://via.placeholder.com/80" alt="用户头像" />
          <h2>玩家昵称</h2>
          <p>Lv.15 游戏狂热者</p>
        </div>
        <div class="menu">
          <a href="#">我的游戏库</a>
          <a href="#">愿望单</a>
          <a href="#">订单记录</a>
          <a href="#">账号设置</a>
        </div>
      </aside>

      <!-- 右侧内容 -->
      <main class="content">
        <div class="card">
          <h3>已购买的游戏</h3>
          <div class="games">
            <div class="game">
              <img src="https://via.placeholder.com/200x120" alt="游戏封面" />
              <p>游戏名称 1</p>
            </div>
            <div class="game">
              <img src="https://via.placeholder.com/200x120" alt="游戏封面" />
              <p>游戏名称 2</p>
            </div>
            <div class="game">
              <img src="https://via.placeholder.com/200x120" alt="游戏封面" />
              <p>游戏名称 3</p>
            </div>
          </div>
        </div>

        <div class="card">
          <h3>我的愿望单</h3>
          <div class="games">
            <div class="game">
              <img src="https://via.placeholder.com/200x120" alt="游戏封面" />
              <p>心愿游戏 1</p>
            </div>
            <div class="game">
              <img src="https://via.placeholder.com/200x120" alt="游戏封面" />
              <p>心愿游戏 2</p>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<style src="../../assets/User/UserHome.css"></style>
