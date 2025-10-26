import { createRouter, createWebHistory } from 'vue-router'

// 主页
import HomeView from '../views/HomeView.vue'
// 论坛
import ForumHome from '@/views/forum/forumHome.vue'
import ForumMain from '@/views/forum/forumMain.vue'
// 登录注册
import Login from '@/views/logres/Login.vue'
import Register from '@/views/logres/Register.vue'
// 我的订单
import gameList from '@/views/games/gameList.vue'
// 用户模块

import ChatUser from '@/views/User/ChatUser.vue'

import UserHome from '@/views/User/UserHome.vue'

// 其它页面
import Community from '@/views/Community.vue'
import Events from '@/views/Events.vue'
import GameDetail from '@/views/GameDetail.vue'
import Home from '@/views/Home.vue'
import Library from '@/views/library.vue'

import Cart from '@/views/User/cart.vue'
import Store from '@/views/Store.vue'
import Myorder from '@/views/User/Myorder.vue'
import forumHome from '@/views/forum/forumHome.vue'

// 游戏商城相关（如果有对应文件）

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    //{ path: '/about', name: 'about', component: () => import('../views/AboutView.vue') },

    // 论坛
    { path: '/forum', name: 'forum-home', component: ForumHome },
    { path: '/forum/main', name: 'forum-main', component: ForumMain },

    // 登录注册
    { path: '/login', name: 'login', component: Login },
    { path: '/register', name: 'register', component: Register },

    // 其它页面
    { path: '/community', name: 'community', component: Community },
    { path: '/events', name: 'events', component: Events },

    { path: '/home', name: 'home2', component: Home },
    { path: '/library', name: 'library', component: Library },

    { path: '/', name: 'home', component: HomeView },
    { path: '/User/cart', name: 'usercart', component: Cart },
    { path: '/User/myorder', name: 'usermyorder', component: Myorder },
    { path: '/homeuser', name: 'userhome', component: UserHome },
    { path: '/store', name: 'store', component: Store },

    // { path: '/store/:id', name: 'game-detail', component: GameDetail },
    { path: '/game/details/:id', name: 'GameDetail', component: GameDetail },
  ],
})

export default router
