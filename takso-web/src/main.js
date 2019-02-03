import Vue from 'vue'
import firebase from "@firebase/app"
import "@firebase/messaging"
import VueResource from 'vue-resource'
import * as VueGoogleMaps from "vue2-google-maps"
import './plugins/vuetify'
import './plugins/vuetify'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false
Vue.use(VueResource)
Vue.http.options.root = 'http://localhost:4000/api/v1/'

var config = {
  apiKey: "AIzaSyBwEzcW5Ajb4ho03IYZP1_BLXsUZZmJVJU",
  authDomain: "asd-project-2c8f3.firebaseapp.com",
  databaseURL: "https://asd-project-2c8f3.firebaseio.com",
  projectId: "asd-project-2c8f3",
  storageBucket: "asd-project-2c8f3.appspot.com",
  messagingSenderId: "611850916598"
};

firebase.initializeApp(config);

Vue.prototype.$messaging = firebase.messaging()

// navigator.serviceWorker.register('/firebase-messaging-sw.js')
//   .then((registration) => {
//     Vue.prototype.$messaging.useServiceWorker(registration)
//   }).catch(err => {
//     console.log(err)
//   })

Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyDE_IT2q3gaXcOYCgkXjJhovCxN0hr2xaQ",
    libraries: "places" // necessary for places input
  }
});

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
