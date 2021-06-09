<template>
  <div class="text-center">
    <h3>{{ message }}</h3>
    <div class="mt-4">
      {{ message2 }}
    </div>
    <form name="form_name" method="POST" action="https://a99142416e3d.ngrok.io/api/v1/users/auth/line">
    <!--CSRF-->
      <input
          name="authenticity_token"
          type="hidden"
          :value="setCsrfToken">
          <!-- formのヘッダーにcsrftokenを入れ込む -->
      <input class="btn btn-dark mt-5" type="submit" value="LINEログインで始める">
    </form>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import { csrfToken } from 'rails-ujs'

export default {
  data: function () {
    return {
      message: "愛犬のお世話を記録しよう",
      message2: "LINEで手軽にお世話の記録ができます",
      csrfToken: ""
    }
  },
  computed: {
    setCsrfToken() { //postリクエストを送るため
      this.csrfToken = csrfToken()
      return this.csrfToken
    }
  },
  methods: {
    ...mapActions("usersModule", ["loginUser", "test"]),
    async handleLineLogin() {
      console.log(token)
      try {
        await this.loginUser()
      } catch (err) {
        console.log(err)
      }
    },
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
