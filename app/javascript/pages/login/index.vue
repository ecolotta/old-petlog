<template>
  <div id="register-form" class="container w-50 text-center">
    <div class="text-center">
      <h1>ログイン</h1>
        <div class="form-group">
          <label for="email">メールアドレス</label>
          <input
            id="email"
            v-model="user.email"
            class="form-control"
            type="email"
          >
        </div>
        <div class="form-group">
          <label for="password">パスワード</label>
          <input
            id="password"
            v-model="user.password"
            class="form-control"
            type="password"
          >
        </div>
        <div class="d-flex justify-content-center mt-5">
          <button
            type="button"
            class="btn btn-primary"
            @click="handleLoginUser"
          >
            ログイン
          </button>
        </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data() {
    return {
      user: {
        email: "",
        password: "",
      },
    }
  },
  methods: {
    ...mapActions("usersModule", ["loginUser"]),
    async handleLoginUser() {
      try {
        await this.loginUser(this.user)
      } catch (err) {
        console.log(err)
      }
    },
  }
}
</script>