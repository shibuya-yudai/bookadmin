<template>
  <div>
    <!--header-->
    <div>
      <b-navbar toggleable="sm" type="light" variant="light">
        <b-navbar-toggle target="nav-text-collapse"></b-navbar-toggle>
        <b-navbar-brand href="/">Book Administrator</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav>
            <b-nav-item v-if="!this.$auth.loggedIn" href="/signup">Sign Up</b-nav-item>
            <b-nav-item v-if="!this.$auth.loggedIn" href="/login">Login</b-nav-item>
            <!--<b-nav-item v-if="this.$auth.loggedIn" href="/addbooks">Add Books</b-nav-item>-->
          </b-navbar-nav>

          <!-- Right aligned nav items -->
          <b-navbar-nav class="ml-auto">

            <b-nav-item-dropdown right v-if="this.$auth.loggedIn">
              <!-- Using 'button-content' slot -->
              <template #button-content>
                <em>{{user.name}}</em>
              </template>
              <b-dropdown-item href="#" disabled>Profile</b-dropdown-item>
              <b-nav-item v-if="this.$auth.loggedIn" href="/update">Edit Account Info</b-nav-item>
              <b-nav-item v-if="this.$auth.loggedIn" @click="logout">Logout</b-nav-item>
            </b-nav-item-dropdown>

          </b-navbar-nav>

        </b-collapse>
      </b-navbar>
    </div>
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
export default ({
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
