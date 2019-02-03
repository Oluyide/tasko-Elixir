<template>
  <v-app>
  <app-header/>
    <v-content>
      <router-view/>
      <app-footer/>
    </v-content>
  
  </v-app>
</template>

<script>
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'

export default {
  name: 'App',
  components: {
     appHeader: Header,
     appFooter: Footer
  },
  data () {
    return {
  
    }
  },
  computed: {
      user() {
        return this.$store.getters.user
    }
  },
  created() {

    this.$messaging
    .requestPermission()
    .then(() => this.$messaging.getToken())
    .then((token) => {
        console.log(token) // Receiver Token to use in the notification
    })
    .catch(function(err) {
        console.log("Unable to get permission to notify.", err);
    });

    this.$messaging.onMessage(function(payload) {
    console.log("Message received. ", payload);
    // ...
    });
  },
  mounted() {
    this.loadUserInfo('token');
  },
  methods: {
    loadUserInfo(){
      // const localToken = localStorage.getItem('token');
      // const user = localStorage.getItem('user');
      // const role = localStorage.getItem('role');
      // if(localToken && user && role){
        this.$store.dispatch('initUser');
        //this.$store.dispatch('registerUser', this._data);
     // }
    }
   }
}
</script>
