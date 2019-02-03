<template>
  <v-app id="inspire">
    <v-content>
      <v-container fluid >
        <v-layout align-center justify-center>
          <v-flex xs12 sm12 md6>
            <v-card class="elevation-12">
              <v-toolbar dark color="dark">
                <v-toolbar-title>Login form</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-btn depressed large to="/register" color="primary">Register User</v-btn>
                <v-btn depressed large to="/registerdriver" color="primary">Register Driver</v-btn>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field prepend-icon="person" name="email" v-model="email"  label="Email" type="email"></v-text-field>
                  <v-text-field id="password" prepend-icon="lock" v-model="password"  name="password" label="Password" type="password"></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="login" color="primary">Login</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
  export default {
    data() {
        return {
            email: '',
            password: ''
        }
    },
    methods: {
       login(){
            this.$store.dispatch('loginUser', this._data);
       }
    }
  }
</script>