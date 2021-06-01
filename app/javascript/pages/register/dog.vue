<template>
  <div id="register-form" class="container w-50 text-center">
    <div class="text-center">
      <h1>愛犬登録</h1>
      <validation-observer v-slot="{ handleSubmit }">
        <div class="form-group">
          <label for="name">愛犬の名前</label>
          <validation-provider
            v-slot="{ errors }"
            name="愛犬の名前"
            rules="required"
          >
            <input
              id="name"
              v-model="dog.name"
              class="form-control"
              type="text"
            >
            <p class="error">
              {{ errors[0] }}
            </p>
          </validation-provider>
        </div>
        <div class="form-group">
          <label for="birthday">愛犬の誕生日</label>
          <validation-provider
            v-slot="{ errors }"
            name="愛犬の誕生日"
            rules="required"
          >
            <input
              id="birthday"
              v-model="dog.birthday"
              class="form-control"
              type="date"
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
            @click="handleSubmit(handleCreateDog)"
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
      dog: {
        name: "",
        birthday: ""
      },
    }
  },
  methods: {
    ...mapActions("usersModule", ["createDog"]),
    async handleCreateDog() {
      try {
        await this.createDog(this.dog)
      } catch (err) {
        console.log(err)
      }
    },
  }
}
</script>