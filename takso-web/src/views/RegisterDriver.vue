<template>
  <v-app id="inspire">
    <v-content>
      <v-container fluid >
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="dark">
                <v-toolbar-title>Driver Registeration form</v-toolbar-title>
                 <v-spacer></v-spacer>
                <v-btn depressed large to="/login" color="primary">Login</v-btn>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field prepend-icon="email" v-model="user.email" name="email" label="Email" type="email"></v-text-field>
                  <v-text-field prepend-icon="person" v-model="user.full_name" name="fullname" label="Full Name" type="text"></v-text-field>
                  <v-text-field prepend-icon="phone" v-model="user.mobile_number" name="telephone" label="Telephone" type="text"></v-text-field>
                  <v-text-field id="password" prepend-icon="lock" v-model="user.password" name="password" label="Password" type="password"></v-text-field>
                  <v-text-field id="password_confirmation" v-model="user.password_confirmation"  prepend-icon="lock" name="password_confirmation" label="Confirm Password" type="password"></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="register" color="primary">Register</v-btn>
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
        return { user: {
            email: '',
            password: '',
            full_name: '',
            mobile_number:'',
            password_confirmation: '',
            role_id: 2,
            device_id: "1234456",
		        wallet: 23.7
        }
      }
    },
    methods: {
       register(){
          this.$store.dispatch('registerUser', this._data);
       }
    }
  }
</script>