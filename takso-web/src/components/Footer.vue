<template>
    <div id="app">
  <v-app id="inspire">
    <v-footer
      dark
      height="auto"
    >
      <v-card
        class="flex"
        flat
        tile
      >
        <v-card-title class="teal">
          <strong class="subheading">Get connected with us on social networks!</strong>
  
          <v-spacer></v-spacer>
  
          <v-btn
            v-for="icon in icons"
            :key="icon.image"
            class="mx-3"
            dark
            :to=icon.url
            icon
          >
            <v-icon size="24px">{{icon.image}}</v-icon>
          </v-btn>
        </v-card-title>
  
        <v-card-actions class="grey darken-3 justify-center">
          &copy;2018 — <strong>Taxi INC</strong>
        </v-card-actions>
      </v-card>
    </v-footer>
  </v-app>
</div>
</template>

<script>
export default {
  data () {
    return {
    icons : [
      { image: 'fab fa-facebook', url:'www.facebook.com' }//,
    //   { image: 'fab fa-twitter', url:'' },
    //   { image: 'fab fa-google-plus', url:'' },
    //   { image: 'fab fa-linkedin', url:'' },
    //   { image: 'fab fa-instagram', url:'' }
    ]
    }
  }
} 
</script>