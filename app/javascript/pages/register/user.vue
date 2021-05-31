<template>
  <div id="register-form">
    <div class="text-center">
      <h1>ユーザー登録</h1>
        <div class="form-group">
          <label for="name">ユーザー名</label>
          <input
            id="name"
            v-model="user.name"
            class="form-control"
            type="text"
          >
        </div>
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
        <div class="form-group">
          <label for="password_confirmation">パスワード（確認）</label>
          <input
            id="password_confirmation"
            v-model="user.password_confirmation"
            class="form-control"
            type="password"
          >
        </div>
        <div class="d-flex justify-content-center mt-5">
          <button
            type="button"
            class="btn btn-primary"
            @click="handleCreateUser"
          >
            登録
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
        name: "",
        email: "",
        password: "",
        password_confirmation: ""
      },
    }
  },
  methods: {
    ...mapActions("usersModule", ["createUser"]),
    async handleCreateUser() {
      try {
        await this.createUser(this.user)
      } catch (err) {
        console.log(err)
      }
    },
  }
}
</script>