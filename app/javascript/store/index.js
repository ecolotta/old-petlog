import Vue from 'vue';
import Vuex from 'vuex';
// import axios from '../plugins/axios'
import usersModule from './modules/users'
import dogCaresModule from './modules/dog_cares'

Vue.use(Vuex); //VuexをVueで使う宣言

export default new Vuex.Store({ //データを置いとく場所を作る、exportしてmain（hello_vue）で読み込む
  modules: {
    usersModule,
    dogCaresModule
  },
});