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
        <b-col class="col-md-4">
          <img src="https://source.unsplash.com/CXYPfveiuis" class="card-img-top" alt="">
        </b-col>
        <b-col class="col-md-8">
          <h2 class="text-center">{{book.title}}</h2>
          <p>{{book.description}}</p>
          <b-btn v-if="this.$auth.loggedIn" @click="addchapter">add chapter</b-btn>
        </b-col>
      </b-row>
    </b-container>
    <b-container fluid class="p-0 d-flex flex-column align-items-center justify-content-center">
      <b-row class="mt-3 w-100">
        <b-col class="col-12">
          <div class="chapter d-flex flex-row" v-for="chapter in chapters" :key="chapter.position">
            <p class="mr-3">chapter0{{chapter.position}}</p>
            <p class="chapter-title">{{chapter.title}}</p>
            <p class="ml-auto mr-3">理解度 100%</p>
            <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            fill="currentColor"
            class="bi bi-plus-circle align-self-center mr-3"
            viewBox="0 0 16 16">
              <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
              <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
            </svg>
            <b-btn @click="deleteChapter()">
              <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              fill="currentColor"
              class="bi bi-trash align-self-center"
              viewBox="0 0 16 16">
                <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
              </svg>
            </b-btn>
          </div>
        </b-col>
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
      user: [],
      book: [],
      chapters: []
    }
  },
  mounted () {
    if (this.$auth.loggedIn) {
      this.$axios.$get('/api/auth/user').then(
        (res) => {
          this.user = res
        }
      )
      this.$axios.$get('/api/auth/books/' + this.$route.query.id).then(
        (res) => {
          this.book = res
        }
      )
      this.getchapters()
    }
  },
  methods: {
    getchapters () {
      this.$axios.$get('/chapters').then(
        (res) => {
          this.chapters = res
          console.log(this.chapters)
        }
      )
    },
    addchapter () {
      let addPosition = 1
      if (this.chapters !== []) {
        addPosition = this.chapters.length + 1
      }
      this.$axios.post('/chapters', {
        book_id: this.book.id,
        title: 'chapter title',
        position: addPosition
      }).then(
        (res) => {
          this.getchapters()
        }
      )
    },
    deleteChapter () {
      this.$destroy()
      this.getchapters()
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
