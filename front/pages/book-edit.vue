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
          <div v-for="chapter in chapters" :key="chapter.position">
            <chapter :chapter="chapter" @reload="getChapters" @reloadposition="reloadChapterPosition"/>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import GlobalHeader from '~/components/GlobalHeader.vue'
import Chapter from '~/components/Chapter.vue'
export default ({
  components: {
    GlobalHeader,
    Chapter
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
      this.getChapters()
    }
  },
  methods: {
    getChapters () {
      this.$axios.$get('/chapters').then(
        (res) => {
          this.chapters = res
          this.reloadChapterPosition()
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
          this.getChapters()
        }
      )
    },
    reloadChapterPosition () {
      this.$axios.patch('/chapters', {
        chapter: this.chapters
      }).then(
        (res) => {
          console.log(res)
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
