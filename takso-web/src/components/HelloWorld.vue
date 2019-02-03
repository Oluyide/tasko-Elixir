<template>
  <v-container>
    <v-layout
      text-xs-center
      wrap
    >
      <v-flex xs12>
      </v-flex>

      <v-flex mb-12>
        <h1 class="display-2 font-weight-bold mb-3">
          Welcome to STRS 
        </h1>
        <p class="subheading font-weight-regular">
          Monitoring our Taxi Network
        </p>
      </v-flex>

      
          <v-flex xs12>
        <v-img
          :src="require('../assets/better_driver.jpg')"
          class="my-3"
          contain
          height="400"
        ></v-img>
      </v-flex>


    </v-layout>
  </v-container>
</template>

<script>
  export default {

  }
</script>

<style>

</style>
