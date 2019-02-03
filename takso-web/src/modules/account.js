import Vue from 'vue';
import router from '../router';

const state = {
  user: null,
  token: null,
  full_name: '',
  wallet: '',
  phone: '',
  role: '',
  error: ''
};

const mutations = {
  'SET_USER' (state, data) {
    state.user = data
  },
  'SET_PHONE' (state, data) {
    state.phone = data
  },
  'SET_FULL_NAME' (state, data) {
    state.full_name = data
  },
  'SET_ROLE' (state, data) {
    state.role = data
  },
  'SET_TOKEN' (state, token) {
    state.token = token
  },
  'SET_WALLET' (state, wallet) {
    state.wallet = wallet
  },
  'SET_ERROR' (state, error) {
    state.error = error
  }
};

const actions = {
  loginUser: ({ commit, dispatch }, user) => {
    Vue.http.post('sign_in', user)
      .then(data => {
        if (data) {
          commit('SET_TOKEN', data.body.loggedin_user.jwt);
          commit('SET_USER', user.email);
          commit('SET_FULL_NAME', data.body.loggedin_user.full_name);
          commit('SET_PHONE', data.body.loggedin_user.mobile_number);
          commit('SET_ROLE', data.body.loggedin_user.role_id);
          commit('SET_WALLET', data.body.loggedin_user.wallet);
          if (data.body.loggedin_user.status) {
            dispatch('pushStatus', data.body.loggedin_user.status);
            localStorage.setItem('status', data.body.loggedin_user.status);
          }
          localStorage.setItem('user', user.email);
          localStorage.setItem('token', data.body.loggedin_user.jwt);
          localStorage.setItem('phone', data.body.loggedin_user.mobile_number);
          localStorage.setItem('full_name', data.body.loggedin_user.full_name);
          localStorage.setItem('role', data.body.loggedin_user.role_id);
          localStorage.setItem('wallet', data.body.loggedin_user.wallet);
          Vue.http.headers.common['Authorization'] = 'Bearer ' + data.body.loggedin_user.jwt
          // todo: pick role from login
          // localStorage.setItem('token', data.body.role);
          router.push('/');
        }
      }, error => {
        commit('SET_ERROR', error);
      });
  },
  registerUser: ({ commit }, user) => {
    Vue.http.post('sign_up', user)
      .then(data => {
        if (data) {
          commit('SET_TOKEN', data.body.jwt);
          commit('SET_USER', user.user.email);
          commit('SET_ROLE', user.user.role_id);
          commit('SET_PHONE', user.user.mobile_number);
          commit('SET_FULL_NAME', user.user.full_name);
          localStorage.setItem('user', user.user.email);
          localStorage.setItem('role', user.user.role_id);
          localStorage.setItem('token', data.body.jwt);
          localStorage.setItem('full_name', user.user.full_name);
          localStorage.setItem('phone', user.user.mobile_number);
          Vue.http.headers.common['Authorization'] = 'Bearer ' + data.body.jwt
          router.push('/');
        }
      }, error => {
        commit('SET_ERROR', error);
      });
  },
  initUser: ({ commit, dispatch }) => {
    let user = localStorage.getItem('user');
    let token = localStorage.getItem('token');
    let role = localStorage.getItem('role');
    let fullname = localStorage.getItem('full_name');
    let phone = localStorage.getItem('phone');
    let wallet = localStorage.getItem('wallet');
    let status = localStorage.getItem('status');
    commit('SET_WALLET', wallet);
    commit('SET_ROLE', role);
    commit('SET_TOKEN', token);
    commit('SET_USER', user);
    commit('SET_FULL_NAME', fullname);
    commit('SET_PHONE', phone);
    commit('SET_STATUS', status);
    dispatch('pushStatus', status);
    Vue.http.headers.common['Authorization'] = 'Bearer ' + token
  },
  logOut: ({ commit, dispatch }) => {
    Vue.http.delete('logout')
      .then(data => {
        commit('SET_ROLE', '');
        commit('SET_TOKEN', '');
        commit('SET_USER', '');
        commit('SET_FULL_NAME', '');
        commit('SET_PHONE', '');
        commit('SET_WALLET', 0);
        dispatch('pushStatus', '');
        localStorage.removeItem('user');
        localStorage.removeItem('token');
        localStorage.removeItem('role');
        localStorage.removeItem('full_name');
        localStorage.removeItem('phone');
        localStorage.removeItem('wallet');
        localStorage.removeItem('status');
        Vue.http.headers.common['Authorization'] = '';
        router.push('/');
      }, error => {
        commit('SET_ERROR', error);
      });    
  }
};

const getters = {
  user: state => {
    return state.user
  },
  full_name: state => {
    return state.full_name
  },
  role: state => {
    return state.role
  },
  phone: state => {
    return state.phone
  },
  token: state => {
    return state.token
  },
  wallet: state => {
    return state.wallet
  },
  error: state => {
    return state.error
  }
};

export default {
  state,
  mutations,
  actions,
  getters
};