<template>
  
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
   async created() {
    await this.loginUser()
    if (!this.currentUser) {
        this.$router.push({ name: 'Index' })
      }
    else if (!this.currentUsersDog) {
      this.$router.push({ name: 'RegisterDog' })
    } 
    else {
      this.$router.push({ name: 'Calender' })
    }
  }
}
</script>