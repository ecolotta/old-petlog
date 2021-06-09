<template>
  <header class="mb-auto">
    <nav class="navbar navbar-dark bg-dark">
      <span class="navbar-brand mb-0 h1">petlog</span>
      <div>
        <template v-if="currentUser">
          <router-link
            to="/profile"
            type="button"
            class="btn btn-dark"
          >
            プロフィール
          </router-link>
          <button
            type="button"
            class="btn btn-dark"
            @click="handleUserLoguout"
          >
            ログアウト
          </button>
        </template>
        <template v-else>
         
        </template>
      </div>
    </nav>
  </header>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters("usersModule", ["currentUser"]),
  },
  methods: {
    ...mapActions("usersModule",["logOutUser"]),
    handleUserLoguout() {
      this.logOutUser(this.currentUser)
      this.$router.push({ path: '/' });
    }
  }
  
}
</script>

<style scoped>
</style>