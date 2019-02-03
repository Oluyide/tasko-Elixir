import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Login from './views/Login.vue'
import RegisterUser from './views/RegisterUser.vue'
import RegisterDriver from './views/RegisterDriver.vue'
import DriverMonitor from './views/DriverMonitor.vue'
import BookTaxi from './views/BookTaxi.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/booktaxi',
      name: 'booktaxi',
      component: BookTaxi
    },
    {
      path: '/drivermonitor',
      name: 'drivermonitor',
      component: DriverMonitor
    },
    {
      path: '/register',
      name: 'register',
      component: RegisterUser
    },
    {
      path: '/registerdriver',
      name: 'registerDriver',
      component: RegisterDriver
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ './views/About.vue')
    }
  ]
})
