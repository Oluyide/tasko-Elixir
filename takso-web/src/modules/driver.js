import Vue from 'vue';
import router from '../router';

const state = {
  status: '',
  location: {},
  balance: 0,
  rating: 0,
  no_of_rating: 0,
  requests: []
};

const mutations = {
  'SET_STATUS' (state, data) {
    state.status = data
  },
  'SET_LOCATION' (state, data) {
    state.location = data
  },
  'SET_BALANCE' (state, data) {
    state.balance = data
  },
  'SET_RATING' (state, data) {
    state.rating = data
  },
  'SET_NO_OF_RATING' (state, data) {
    state.noOfRating = data
  },
  'SET_REQUESTS' (state, data) {
    state.requests = data
  }
};

const actions = {
  driverLocation: ({ commit }, location) => {
    
    // if (this.getters.role === '1') return
    Vue.http.patch('update_driver_location', location)
      .then(data => {
        if (data) {
          commit('SET_LOCATION', location);
        }
      }, error => {
        commit('SET_ERROR', error);
      });
  },
  changeStatus: ({ commit }, status) => {
    Vue.http.patch('update_status', status)
      .then(data => {
        if (data) {
          console.log(data)
          commit('SET_STATUS', status.location_data.status);
        }
      }, error => {
        commit('SET_ERROR', error);
      });
  },
  pushStatus: ({ commit }, status) => {
    commit('SET_STATUS', status);
  },
  pushRating: ({ commit, dispatch }, rating) => {

    Vue.http.patch('rate_driver', rating)
      .then(data => {
        console.log(data);
        // commit('SET_RATING', rating);
      }, error => {
        dispatch('error', error);
      });
  },
  refreshRequest: ({ commit, dispatch }) => {
    
    Vue.http.get('get_order_for_drivers')
      .then(data => {
        // console.log(data.body);
        commit('SET_REQUESTS', data.body);
      }, error => {
        dispatch('error', error);
      });
  },
  acceptRequest: ({ commit }, id) => {
    Vue.http.patch('accept_order',id)
      .then(data => {
        console.log(data);
      // commit('SET_RATING', rating);
      }, error => {
        commit('SET_ERROR', error);
      });
  },
  rejectRequest: ({ commit }, id) => {
    Vue.http.patch('reject_order', id)
      .then(data => {
        console.log(data);
        // commit('SET_RATING', rating);
      }, error => {
        commit('SET_ERROR', error);
      });
  },
  journeyComplete: ({ commit }, id) => {
    Vue.http.patch('ride_complete', id)
      .then(data => {
        console.log(data);
      // commit('SET_RATING', rating);
      }, error => {
        commit('SET_ERROR', error);
      });
  }
};

const getters = {
  status: state => {
    return state.status
  },
  location: state => {
    return state.location
  },
  balance: state => {
    return state.balance
  },
  rating: state => {
    return state.rating
  },
  no_of_rating: state => {
    return state.no_of_rating
  },
  requests: state => {
    return state.requests
  }
};

export default {
  state,
  mutations,
  actions,
  getters
};