import axios from '../../plugins/axios.js'

const state = {
 
};
const mutations = {
  
};
const actions = {
  createUser( { commit }, user) {
    return axios
    .post('users', user)
    // .then(res =>{ commit('addUser', res.data)})
  },
};
const getters = {
 
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
}