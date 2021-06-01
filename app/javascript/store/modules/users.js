import axios from '../../plugins/axios.js'

const state = {
 currentUser: null,
};
const mutations = {
  setCurrentUser(state, user) {
    this.currentUser = user
  }
};
const actions = {
  createUser( { commit }, user) {
    return axios
    .post('users', user)
    // .then(res =>{ commit('addUser', res.data)})
  },
  async loginUser( {commit }, user) {
    await axios
    .post('sessions', user)
    .then(res => {
      localStorage.setItem('token', res.data.token)
      axios.defaults.headers.common['Authorization'] = `Bearer ${res.data.token}`
    })
    const userResponse = await axios.get('me')
    commit('setCurrentUser', userResponse.data)
    console.log(this.currentUser)
  },
  logOutUser() {
    localStorage.deleteItem('token')
    this.currentUser = null
  },
  async fetchAuthUser({ commit, state }) {
    try{
      if (!localStorage.token) return null
      if (state.currentUser) return state.currentUser

      const userResponse = await axios.get('me')
        .catch((err) => {
          return null
        })
      if (!userResponse) return null

      const authUser = userResponse.data
      if (authUser) {
        commit('setCurrentUser', authUser)
        return authUser
      } else {
        commit('setCurrentUser', null)
        return null
      } 
    } catch (err) {
      console.log(err)
    }
  }
};
const getters = {
  currentUser: state => state.currentUser,
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
}