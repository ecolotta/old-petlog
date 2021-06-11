<template>
  <div
    class="col-3 bg-light rounded shadow m-3 p-3"
  >
  <template v-if="currentUserDogCares">
  <!-- {{ currentUser }} -->
  {{ currentUsersDog.name }}
  <br>


  {{ setCareType(currentUserDogCares[1]) }}
   <br>

      {{ setCareType(currentUserDogCares[2]) }}  
    </template>
      <template v-else>
        <div>LINEからお世話を登録しましょう</div>
        </template>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  data: function () {
    return {
     
    }
  },
  created() {
    this.fetchCares(this.currentUser)
    this.fetchCareTypes()
  },
  computed: {
    ...mapGetters("usersModule",["currentUser", "currentUsersDog"]),
    ...mapGetters("dogCaresModule",["currentUserDogCares", "careTypes"]),
  },
  methods: {
    ...mapActions("dogCaresModule",["fetchCares", "fetchCareTypes"]),
    setCareType(care) {
      var result = this.careTypes.find(type => type.id === care.care_type_id)
      return result.name
    },
  },
  
}
</script>
