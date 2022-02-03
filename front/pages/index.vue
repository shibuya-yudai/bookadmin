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
        <b-col class="col-md-3" v-for="book in books" :key="book.id">
          <div class="card w-100">
            <img src="https://source.unsplash.com/CXYPfveiuis" class="card-img-top" alt="">
            <div class="card-body">
              <h5 class="card-title">{{book.title}}</h5>
              <p class="card-text">{{book.description}}</p>
              <button type="button" class="btn btn-primary" @click="openModal(book)">
                more
              </button>
              <modal :book="postItem" v-show="showContent" @close="closeModal" />
            </div>
          </div>
        </b-col>
      </b-row>
      <div class="mt-3">
        <b-btn v-if="this.$auth.loggedIn" @click="addbook">add books</b-btn>
      </div>
    </b-container>
  </div>
</template>

<script>
import GlobalHeader from '~/components/GlobalHeader.vue'
import Modal from '~/components/Modal.vue'
export default ({
  components: {
    GlobalHeader,
    Modal
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
      this.getbooks()
    }
  },
  methods: {
    getbooks () {
      this.$axios.$get('/api/auth/books').then(
        (res) => {
          this.books = res
          // console.log(this.books)
        }
      )
    },
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
    },
    addbook () {
      this.$axios.post('/books', {
        user_id: this.user.id
      }).then(
        (res) => {
          console.log('success!: ' + res)
          this.getbooks()
        }
      )
    },
    openModal (book) {
      this.showContent = true
      this.postItem = book
    },
    closeModal () {
      this.showContent = false
      this.getbooks()
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
