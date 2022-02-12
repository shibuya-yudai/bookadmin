
<template>
  <div class="section d-flex flex-row">
    <p class="mr-3">section0{{section.position}}</p>
    <template v-if="f">
      <input v-model="tmpTitle" @keyup.enter="setTitle" @blur="setTitle" ref="r1" />
    </template>
    <template v-else>
      <span class="section-title" @click="c">{{tmpTitle}}</span>
    </template>
    <b-form-rating class="ml-auto" v-model="starValue" ></b-form-rating>
    <b-btn class="trash-btn" @click="deleteSection">
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
  props: ['section'],
  data () {
    return {
      newTitle: '',
      f: false,
      starValue: this.section.understand_rate
    }
  },
  mounted () {
    // this.getsections()
  },
  computed: {
    tmpTitle: {
      get () {
        if (!this.newTitle) {
          return this.section.title
        }
        return this.newTitle
      },
      set (val) {
        if (val !== '') {
          this.newTitle = val
        }
      }
    }
  },
  watch: {
    starValue () {
      this.$axios.patch('/sections/' + this.section.id, {
        understand_rate: this.starValue
      }).then(
        (res) => {
        }
      )
    }
  },
  methods: {
    deleteSection () {
      this.$axios.delete('/sections/' + this.section.id, {
      }).then(
        (res) => {
          console.log('success!: ' + res)
          this.$emit('reload')
        }
      )
    },
    c () {
      this.f = true
      this.$nextTick(function () { this.$refs.r1.focus() })
    },
    setTitle () {
      this.f = false
      this.$axios.patch('/sections/' + this.section.id, {
        title: this.newTitle
      }).then(
        (res) => {
        }
      )
    }
  }
})
</script>

<style>
.section{
  background-color: #fff;
  width: 100%;
  color: #707070;
  padding-top: 15px;
  padding-bottom: 15px;
  padding-left: 20px;
  padding-right: 15px;
  border-bottom: 1px solid #4b4b4b;
}
.section p{
  margin: 0;
}
.section-title{
  font-size: 16px;
}
.bi-trash,.bi-plus-circle{
  color: black;
}
.bi-star, .bi-star-fill{
  color: rgb(250, 200, 0);
}
.trash-btn,.plus-btn{
  background-color: transparent;
}
.form-control{
  width: initial;
  border: none;
}
</style>
