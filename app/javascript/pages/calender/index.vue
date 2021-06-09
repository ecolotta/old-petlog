<template>
  <div>hello!</div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  data: function () {
    return {
     
    }
  },
  computed: {
    ...mapGetters("usersModule",["currentUser", "currentUsersDog"]),
  },
  methods: {
    ...mapActions("usersModule", ["loginUser"]),
  },
}
</script>
