<template>
  <div class="text-center">
    <h3>{{ message }}</h3>
    <div class="mt-4">
      {{ message2 }}
    </div>
    <router-link
      to="/register"
      type="button"
      class="btn btn-dark mt-5"
    >
      はじめる
    </router-link>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "タスクを管理しよう！",
      message2: "生活や仕事に関するタスクを見える化して抜け漏れを防ぎましょう。"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
