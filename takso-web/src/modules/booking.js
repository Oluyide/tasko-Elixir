import Vue from 'vue';
import router from '../router';

const state = {
  driver: null,
  driverMatrix: null,
  booking: null,
  // default to Tartu
  pickup: { lat: 58.3780, lng: 26.7290 },
  destination: null,
  bookersLocation: null
};

const mutations = {
  'SET_BOOKING' (state, data) {
    state.booking = data
  },
  'SET_PICKUP' (state, data) {
    state.pickup = data
  },
  'SET_DESTINATION' (state, token) {
    state.destination = token
  },
  'SET_BOOKER_ADDRESS' (state, data) {
    state.bookersLocation = data
  },
  'SET_DRIVER' (state, data) {
    state.driver = data
  },
  'SET_DRIVER_MATRIX' (state, data) {
    state.driverMatrix = data
  }
};

const actions = {
  setBookTripData: ({ commit }, booking) => {
    commit('SET_BOOKING', booking)
    // Vue.http.post('sign_in', user)
    //   .then(data => {
    //     if (data) {
    //       commit('SET_TOKEN', data.body.jwt);
    //       commit('SET_USER', user.email);
    //       localStorage.setItem('users', user.email);
    //       localStorage.setItem('token', data.body.jwt);
    //       // todo: pick role from login
    //       // localStorage.setItem('token', data.body.role);
    //       router.push('/');
    //     }
    //   }, error => {
    //     commit('SET_ERROR', error);
    //   });
  },
  clearBooking: (({ commit }) => {
    commit('SET_BOOKING', null);
    commit('SET_PICKUP', { lat: 58.3780, lng: 26.7290 });
    commit('SET_DESTINATION', null);
    commit('SET_BOOKER_ADDRESS', null);
    commit('SET_DRIVER', null);
    commit('SET_DRIVER_MATRIX', null);
  }),
  setBookerAddress: ({ commit }, bookerLocation) => {
    commit('SET_BOOKER_ADDRESS', bookerLocation)
  },
  pickup: ({ commit }, pickup) => {
    commit('SET_PICKUP', pickup)
  },
  destination: ({ commit }, destination) => {
    console.log(destination)
    commit('SET_DESTINATION', destination)
  },
  distanceMatrixCallBack: ( response) => {// { commit },
    console.log(response)
    if (response && response.destinationAddresses && response.destinationAddresses.length > 0) {
      mutations.SET_DRIVER_MATRIX(state, {'destinationAddresses' : response.destinationAddresses[0], 'originAddresses': response.originAddresses[0], 'distance': response.rows[0].elements[0].duration.text });
    } else {
      mutations.SET_DRIVER_MATRIX(state, {'destinationAddresses' : '..computing location..', 'originAddresses': '..computing location..', 'distance': '..computing time..' });
    }
  },
  bookTrip: ({ commit, dispatch }, bookingData) => {
    Vue.http.post('book_a_car', bookingData)
      .then(data => {
        commit('SET_DRIVER', data.body)
        dispatch('pushRating', data.body.average_rating)
        // Vue.http.post('', data.driver_lat_long)
        if (data.body.message) {
          mutations.SET_DRIVER_MATRIX(state, {'message' : data.body.message});
          return
        }

        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix({
          origins: [new google.maps.LatLng(data.body.driver_lat_long.coordinates[1], data.body.driver_lat_long.coordinates[0])],
          destinations: [new google.maps.LatLng(state.pickup.lat, state.pickup.lng),],
          travelMode: 'DRIVING'}, actions.distanceMatrixCallBack);

      }, error => {
        commit('ERROR', error)
        // console.log(error)
      });
  }
};

const getters = {
  booking: state => {
    let booking = state.booking
    if (!!booking && booking.rows && (booking.rows.length > 0) && (booking.rows[0].elements) && (booking.rows[0].elements.length > 0)) {
      return { distance: booking.rows[0].elements[0].distance.text,
        duration: booking.rows[0].elements[0].duration.text,
        destinationAddresses: booking.destinationAddresses[0],
        originAddresses: booking.originAddresses[0]
      }
    } else {
      if (state.bookersLocation) {
        return { distance: 'computing...',
          duration: 'computing...',
          destinationAddresses: 'computing...',
          originAddresses: state.bookersLocation
        }
      }
      return null
    }
  },
  pickup: state => {
    return state.pickup
  },
  destination: state => {
    return state.destination
  },
  driver: state => {
    return state.driver
  },
  driverMatrix: state => {
    return state.driverMatrix
  }
};

export default {
  state,
  mutations,
  actions,
  getters
};