<template>
  <div class="container">
    <br>
    <div class="box">
      <h2 class="is-size-4 has-text-centered">Login</h2>
      <hr class="hr">
      <form @submit.prevent="login({ username, password})" class="form">
        <div class="field">
          <label class="label">Username</label>
          <div class="control">
            <input v-model="username" class="input" type="text" placeholder="homerjsimpson">
          </div>
        </div>
        <div class="field">
          <label class="label">Password</label>
          <div class="control">
            <input v-model="password" class="input" type="password" placeholder="super secure password">
          </div>
        </div>
        <div class="field is-grouped">
          <div class="control">
            <button class="button is-link" type="submit">Submit</button>
          </div>
          <div class="control">
            <a class="button is-light" href="/signup">Sign up</a>
          </div>
        </div>
        <p><small><a @click="() => {username='normaluser'; password='normaluser'}">Normal user: normaluser/normaluser</a></small></p>
        <p><small><a @click="() => {username='betauser'; password='betauser'}">Beta user: betauser/betauser</a></small></p>
        <p><small><a @click="() => {username='admin'; password='admin'}">Admin user: admin/admin</a></small></p>
      </form>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import { mapGetters } from 'vuex'
import { isLoggedIn } from '../utils/users'

export default {
  name: 'home',
  data () {
    return {
      username: '',
      password: ''
    }
  },
  computed: {
    ...mapGetters([
      'isLoggedIn'
    ])
  },
  methods: {
    login () {
      this.$store.dispatch('login', {
        username: this.username,
        password: this.password
      }).then(() => {
        if (isLoggedIn()) {
          this.$router.push('/')
        }
      })
    }
  }
}
</script>
