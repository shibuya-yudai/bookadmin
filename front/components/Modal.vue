
<template>
  <div id="overlay">
    <div id="content">
      <!--<img :src="val.img_src">-->
      <p>{{book}}</p>
      <b-form-input v-model="title" placeholder="Enter book's title."></b-form-input>
      <b-form-input v-model="description" placeholder="Enter book's description."></b-form-input>
      <button @click="movePage()">詳細</button>
      <button @click="$emit('close')">閉じる</button>
      <button @click="updateBookInfo()">保存</button>
      <button @click="deleteBook(); $emit('close')">この本を削除する</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Modal',
  props: ['book'],
  data () {
    return {
      title: '',
      description: ''
    }
  },
  methods: {
    updateBookInfo () {
      this.$axios.patch('/books/' + this.book.id, {
        title: this.title,
        description: this.description
      }).then(
        (res) => {
          console.log('success!: ' + res)
          this.title = ''
          this.description = ''
        }
      )
    },
    deleteBook () {
      this.$axios.delete('/books/' + this.book.id, {
      }).then(
        (res) => {
          console.log('success!: ' + res)
        }
      )
    },
    movePage () {
      this.$router.push({
        path: 'book-edit',
        query: { id: this.book.id }
      })
    }
  }
}
</script>

<style>
  #overlay{
  z-index:1;
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-color:rgba(0, 0, 0, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
}

#content{
  z-index:2;
  width:50%;
  padding-top: 5em;
  padding-bottom: 5em;
  text-align: center;
  background-color: whitesmoke;
}

#content > img {
  width: 95%;
}
</style>
