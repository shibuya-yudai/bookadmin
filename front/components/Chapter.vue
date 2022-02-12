
<template>
  <div>
    <div class="chapter d-flex flex-row" v-bind:style='{backgroundColor: color}'>
      <p class="mr-3">chapter0{{chapter.position}}</p>
      <template v-if="f">
        <input v-model="tmpTitle" @keyup.enter="setTitle" @blur="setTitle" ref="r1" />
      </template>
      <template v-else>
        <span class="chapter-title" @click="c">{{tmpTitle}}</span>
      </template>
      <p class="ml-auto mr-3">理解度 {{understand_persent}}%</p>
      <b-btn class="plus-btn mr-3" @click="addSection">
        <svg
        xmlns="http://www.w3.org/2000/svg"
        width="16"
        height="16"
        fill="currentColor"
        class="bi bi-plus-circle align-self-center"
        viewBox="0 0 16 16">
          <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
        </svg>
      </b-btn>
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
    <template v-for="section in sections">
      <ba-section :key="section.id" :section="section"  @reload="getSections"/>
    </template>
  </div>
</template>

<script>
import BaSection from '~/components/BaSection.vue'
export default ({
  components: {
    BaSection
  },
  props: ['chapter'],
  data () {
    return {
      sections: [],
      newTitle: '',
      understand_persent: 0,
      f: false,
      colors: {
        gray: '#f0f0f0',
        green: 'rgb(177, 237, 135)',
        blue: 'rgb(135, 230, 237)',
        yellow: 'rgb(223, 237, 135)',
        orange: 'rgb(237, 196, 135)',
        red: 'rgb(237, 135, 135)'
      },
      color: ''
    }
  },
  mounted () {
    this.getSections()
  },
  computed: {
    tmpTitle: {
      get () {
        if (!this.newTitle) {
          return this.chapter.title
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
  methods: {
    getSections () {
      this.$axios.$get('/api/auth/section/' + this.chapter.id).then(
        (res) => {
          this.sections = res
          this.reloadSectionPosition()
          if (this.sections.length !== 0) {
            let sum = 0
            this.sections.forEach((element) => {
              sum += element.understand_rate
            })
            this.understand_persent = (sum / (this.sections.length * 5)) * 100
          } else {
            this.understand_persent = 0
          }
          switch (true) {
            case this.understand_persent < 20: {
              this.color = this.colors.gray
              break
            }
            case this.understand_persent < 40: {
              this.color = this.colors.green
              break
            }
            case this.understand_persent < 60: {
              this.color = this.colors.blue
              break
            }
            case this.understand_persent < 80: {
              this.color = this.colors.yellow
              break
            }
            case this.understand_persent < 100: {
              this.color = this.colors.orange
              break
            }
            case this.understand_persent === 100: {
              this.color = this.colors.red
              break
            }
            default: {
              this.color = this.colors.gray
            }
          }
        }
      )
    },
    reloadSectionPosition () {
      this.$axios.patch('/sections', {
        section: this.sections
      }).then(
        (res) => {
          // console.log(res)
        }
      )
    },
    addSection () {
      let addPosition = 1
      if (this.sections !== []) {
        addPosition = this.sections.length + 1
      }
      this.$axios.post('/sections', {
        chapter_id: this.chapter.id,
        title: 'section title',
        position: addPosition
      }).then(
        (res) => {
          this.getSections()
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
    },
    c () {
      this.f = true
      this.$nextTick(function () { this.$refs.r1.focus() })
    },
    setTitle () {
      this.f = false
      this.$axios.patch('/chapters/' + this.chapter.id, {
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
.bi-trash,.bi-plus-circle{
  color: black;
}
.trash-btn,.plus-btn{
  background-color: transparent;
}
</style>
