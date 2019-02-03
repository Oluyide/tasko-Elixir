<template>
    <v-toolbar app>
      <v-toolbar-title class="headline text-uppercase">
        <span>STRS</span>
        <span v-if="!!user && role == 1" class="font-weight-light">-User</span>
        <span v-if="!!user && role == 2" class="font-weight-light">-Driver</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <span>€{{wallet}}</span>
      <v-btn flat v-if="!!user" to="/" >Home</v-btn>
      <v-btn flat v-if="!!user && role == 1" to="/booktaxi" >Book Taxi</v-btn>
      <v-btn flat v-if="!!user && role == 2" to="/drivermonitor" >Driver Monitor</v-btn>
     
      <v-btn
        flat
        to="/login"
        v-if="!user"
      >
        <span  class="mr-2">Login in</span>
        <v-icon>open_in_new</v-icon>
      </v-btn>
        <v-menu  v-if="!!user" offset-y>
        <v-btn
          slot="activator"
          color="primary"
          dark
        >
          Hi {{user}}
        </v-btn>
        <v-list>
          <v-list-tile
            v-for="(item, index) in accountMenuItem"
            :key="index"
            @click="item.callFunc"
          >
            <v-list-tile-title>{{ item.title }}</v-list-tile-title>
          </v-list-tile>
        </v-list>
       </v-menu>
    
    </v-toolbar>

</template>

<script>
   export default {
  data () {
    return {
     accountMenuItem: [
      { title: 'Log Out', callFunc: this.logout }
      ]
    }
  },
  computed: {
    user() {
        return this.$store.getters.user
    },
     wallet() {
        return this.$store.getters.wallet
    },
    role(){
        return this.$store.getters.role
    }
  },
    methods: {
      logout() {
        this.$store.dispatch('logOut'); 
      }
   }
} 
</script>