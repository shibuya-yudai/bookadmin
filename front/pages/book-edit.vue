<template>
  <div>
    <!--header-->
    <global-header />
    <!--/header-->

    <!--hero-->
    <b-container fluid class="hero p-0 d-flex flex-column align-items-center justify-content-center">
      <!-- Content here -->
      <h2 class="text-light">You can manage knowledge in this site!</h2>
      <p class="text-light">hello {{user.name}} !!</p>
    </b-container>
    <b-container class="p-0 mt-3 d-flex flex-column align-items-center justify-content-center">
      <!-- Content here -->
      <b-row>
        {{this.$route.query.id}}
      </b-row>
    </b-container>
  </div>
</template>

<script>
import GlobalHeader from '~/components/GlobalHeader.vue'
export default ({
  components: {
    GlobalHeader
  },
  data () {
    return {
      showContent: false,
      postItem: '',
      user: [],
      books: []
    }
  },
  mounted () {
    if (this.$auth.loggedIn) {
      this.$axios.$get('/api/auth/user').then(
        (res) => {
          this.user = res
        }
      )
    }
  },
  methods: {
    async logout () {
      await this.$auth.logout().then(
        () => {
          localStorage.removeItem('access-token')
          localStorage.removeItem('client')
          localStorage.removeItem('uid')
          localStorage.removeItem('token-type')
          this.user = []
          this.books = []
        }
      )
    }
  }
})
</script>

<style>
.hero{
  position: relative;
  height: 50vh;
  background-image: url(https://source.unsplash.com/YLSwjSy7stw);
}
</style>
