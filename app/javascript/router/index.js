import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'
import Home from '../pages/top/index.vue'
import RegisterDog from '../pages/register/dog.vue'
import Redirect from '../pages/redirect/index.vue'
import Calender from '../pages/calender/index'

Vue.use(VueRouter)

const routes = [
  { 
    path: '/', 
    component: Home,
    name: 'Index'
  },
  { 
    path: '/register_dog', 
    component: RegisterDog,
    name: 'RegisterDog',
    meta: { requiredAuth: true },
  },
  {
    path: '/redirect',
    component: Redirect,
  },
  {
    path: '/calender',
    component: Calender,
    name: 'Calender',
    meta: { requiredAuth: true },
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

router.beforeEach((to, from, next) => {
  store.dispatch('usersModule/fetchAuthUser').then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
      next({ name: 'Index' });
    } else {
      next();
    }
  })
}); 

if (localStorage.auth_token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
}

export default router
