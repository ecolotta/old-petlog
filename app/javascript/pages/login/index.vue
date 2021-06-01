<template>
  <div id="login-form" class="container w-50 text-center">
    <div class="text-center">
      <h1>ログイン</h1>
      <validation-observer v-slot="{ handleSubmit }">
        <div class="form-group">
          <label for="email">メールアドレス</label>
          <validation-provider
            v-slot="{ errors }"
            name="メールアドレス"
            rules="email|required"
          >
            <input
              id="email"
              v-model="user.email"
              class="form-control"
              type="email"
            >
            <p class="error">
              {{ errors[0] }}
            </p>
          </validation-provider>
        </div>
        <div class="form-group">
          <label for="password">パスワード</label>
          <validation-provider
            v-slot="{ errors }"
            name="パスワード"
            rules="min:3|required"
          >
            <input
              id="password"
              v-model="user.password"
              class="form-control"
              type="password"
            >
            <p class="error">
              {{ errors[0] }}
            </p>
          </validation-provider>
        </div>
        <div class="d-flex justify-content-center mt-5">
          <button
            type="button"
            class="btn btn-primary"
            @click="handleSubmit(handleLoginUser)"
          >
            ログイン
          </button>
        </div>
      </validation-observer>
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