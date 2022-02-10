
<template>
  <div class="chapter d-flex flex-row">
    <p class="mr-3">chapter0{{chapter.position}}</p>
    <p class="chapter-title">{{chapter.title}}</p>
    <p class="ml-auto mr-3">理解度 100%</p>
    <!--
    <b-btn @click="addChapter">
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
    </b-btn>
    -->
    <b-btn class="trash-btn" @click="deleteChapter">
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
</template>

<script>
export default ({
  props: ['chapter'],
  data () {
    return {
      chapters: []
    }
  },
  mounted () {
    // this.getChapters()
  },
  methods: {
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
    deleteChapter () {
      this.$axios.delete('/chapters/' + this.chapter.id, {
      }).then(
        (res) => {
          console.log('success!: ' + res)
          this.$emit('reload')
          this.$emit('reloadposition')
        }
      )
    }
  }
})
</script>

<style>
.chapter{
  background-color: #f0f0f0;
  width: 100%;
  color: #707070;
  padding: 15px;
  border-bottom: 1px solid #4b4b4b;
}
.chapter p{
  margin: 0;
}
.chapter-title{
  font-size: 20px;
}
.bi-trash{
  color: black;
}
.trash-btn{
  background-color: transparent;
}
</style>
