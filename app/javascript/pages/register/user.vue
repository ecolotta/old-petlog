<template>
  <div id="register-form" class="container w-50 text-center">
    <div class="text-center">
      <h1>ユーザー登録</h1>
      <validation-observer v-slot="{ handleSubmit }">
        <div class="form-group">
          <label for="name">ユーザー名</label>
          <validation-provider
            v-slot="{ errors }"
            name="ユーザー名"
            rules="required"
          >
            <input
              id="name"
              v-model="user.name"
              class="form-control"
              type="text"
            >
            <p class="error">
              {{ errors[0] }}
            </p>
          </validation-provider>
        </div>
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
            vid="password"
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
        <div class="form-group">
          <label for="password_confirmation">パスワード（確認）</label>
          <validation-provider
            v-slot="{ errors }"
            name="パスワード（確認）"
            rules="required|min:3|confirmation:@password"
          >
            <input
              id="password_confirmation"
              v-model="user.password_confirmation"
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
            @click="handleSubmit(handleCreateUser)"
          >
            登録
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
        name: "",
        email: "",
        password: "",
        password_confirmation: ""
      },
    }
  },
  methods: {
    ...mapActions("usersModule", ["createUser", "loginUser"]),
    async handleCreateUser() {
      try {
        await this.createUser(this.user)
        .then(res => {
          this.loginUser(this.user) //create後勝手にログイン
          this.$router.push({ path: 'register_dog' })
        })
      } catch (err) {
        console.log(err)
      }
    },
  }
}
</script>