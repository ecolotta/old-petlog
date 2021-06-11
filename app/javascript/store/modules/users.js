import axios from '../../plugins/axios.js'

const state = {
 currentUser: null,
 currentUsersDog: null,
};
const mutations = {
  setCurrentUser(state, user) {
    state.currentUser = user
  },
  setCurrentUsersDog(state, dog) {
    state.currentUsersDog = dog
  }
};
const actions = {
  createUser( { commit }, user) {
    return axios
    .post('users', user)
  },
  createDog( {commit }, dog) {
    return axios
    .post('dogs', dog)
  },
  async loginUser( {commit }) {
    try {
      await axios
      .get('token')
      .then(res => { 
        localStorage.setItem('token', res.data.token)
        axios.defaults.headers.common['Authorization'] = `Bearer ${res.data.token}`
      })
    } catch (err) {
      return null
    }
    const userResponse = await axios.get('me')
    commit('setCurrentUser', userResponse.data[0])
    commit('setCurrentUsersDog', userResponse.data[1])
  },
  logOutUser( {commit} ) {
    axios.get('/sign_out')
    localStorage.removeItem('token')
    state.currentUser = null
    state.currentUsersDog = null
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

      const authUser = userResponse.data[0]
      const authDog = userResponse.data[1]
      if (authUser) {
        commit('setCurrentUser', authUser)
        if (authDog) {
          commit('setCurrentUsersDog', authDog)
        }
        return authUser
      } else {
        commit('setCurrentUser', null)
        return null
      } 
    } catch (err) {
      console.log(err)
    }
  },
};
const getters = {
  currentUser: state => state.currentUser,
  currentUsersDog: state => state.currentUsersDog,
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
}