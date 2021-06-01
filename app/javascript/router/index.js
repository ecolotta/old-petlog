import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'
import Home from '../pages/top/index.vue'
import RegisterUser from '../pages/register/user.vue'
import Login from '../pages/login/index'

Vue.use(VueRouter)

const routes = [
  { 
    path: '/', 
    component: Home,
  },
  { 
    path: '/register', 
    component: RegisterUser,
  },
  { 
    path: '/login', 
    component: Login,
    name: 'LoginIndex',
    // meta: { requiredAuth: true }
  },
]

const router = new VueRouter({
  mode: 'history',
  routes
})

router.beforeEach((to, from, next) => {
  store.dispatch('usersModule/fetchAuthUser').then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
      next({ name: 'LoginIndex' });
    } else {
      next();
    }
  })
}); 

export default router
