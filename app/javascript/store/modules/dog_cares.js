import axios from '../../plugins/axios.js'

const state = {
  currentUserDogCares: [],
  careTypes: []
};
const mutations = {
  loadCares(state, cares) {
    state.currentUserDogCares = cares
  },
  loadCareTypes(state, types) {
    state.careTypes = types
  }
};

const actions = {
  async fetchCares({ commit }, user) {
    await axios.get('dog_cares/' + user.id)
    .then(res => { commit('loadCares', res.data)})
    .catch(err => console.log(err))
  },
  async fetchCareTypes({ commit }) {
    await axios.get('care_types')
    .then(res => { commit('loadCareTypes', res.data)})
    .catch(err => console.log(err))
  },
};

const getters = {
  currentUserDogCares: state => state.currentUserDogCares,
  careTypes: state => state.careTypes,
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
}