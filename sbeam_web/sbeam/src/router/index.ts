import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import GameCategoryView from '@/views/GameMall/GameCategoryView.vue'
import GameSortView from '../views/GameMall/GameSortView.vue'
import GameSearchView from '../views/GameMall/GameSearchView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue'),
    },
    {
       path: '/games/category',
       name: 'game-category',
       component: GameCategoryView
    },
    {
  path: '/games/sort',
  name: 'game-sort',
  component: GameSortView
    },
    {
  path: '/games/search',
  name: 'game-search',
  component: GameSearchView
    }
  ],
})

export default router
