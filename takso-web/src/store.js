import Vue from 'vue'
import Vuex from 'vuex'

import account from './modules/account'
import booking from './modules/booking'
import driver from './modules/driver'

Vue.use(Vuex)

export default new Vuex.Store({
  // state: {

  // },
  // mutations: {
    
  // },
  // actions: {

  // },
  modules: {
    driver,
    booking,
    account
  }
})
