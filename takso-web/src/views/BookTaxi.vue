<template>

   <v-app id="inspire">
    <v-layout>
      <v-flex xs12 sm12 >
      <v-flex xs12 sm6 md3>
        <!-- <v-text-field prepend-icon="person" name="fullname" v-model="name"  label="Full Name" type="text"></v-text-field> -->
       </v-flex>
       <v-card>

          <v-alert
            :value="true"
            type="success"
            v-if="driver && diverMatrix && !driver.message"
          >
             
            <span>Your driver </span><span style="font-size: 16px; font-weight: bold">{{driver.driver_name + ' ('+driver.driver_mobile_num +') ' }}
              </span> now at <span style="font-size: 16px; font-weight: bold" >{{ diverMatrix.originAddresses }}</span><span> will arrives in  </span>
              <span style="font-size: 16px; font-weight: bold" >{{ diverMatrix.distance }}.</span><span>The ride will cost</span>
              <span style="font-size: 16px; font-weight: bold" >{{ diverMatrix.ride_cost }}.</span>
          </v-alert>

           <v-alert
            :value="true"
            type="error"
            v-if="driver && diverMatrix && !!driver.message"
          > 
           <span style="font-size: 16px; font-weight: bold">{{driver.message}}</span> 
          </v-alert>

          <gmap-map
          ref="mapcanvas"
          :center="center"
          :zoom="13"
          style="width:100%;  height: 450px;">
          <gmap-marker
            :key="index"
            v-for="(m, index) in markers"
            :position="m.position"
            @click="center=m.position">
          </gmap-marker>
         </gmap-map>

         
          <v-card-title>
            <!-- <div>
              <span class="grey--text">Number 10</span><br>
              <span>Whitehaven Beach</span><br>
              <span>Whitsunday Island, Whitsunday Islands</span>
            </div> -->

          <v-flex xs12 md4>
            <h2>Pickup Address</h2>
            <gmap-autocomplete
            style="width: 300px; height: 40px; padding-right: 20px"
            placeholder="Present Location"
              @place_changed="setCurrentPlace">
            </gmap-autocomplete>
            <div class="text-xs-center">
              <v-btn primary  @click="setPickupAddress" color="green">
              Change Pickup
              </v-btn>
            </div>
          </v-flex>

          <!-- <v-flex xs4 sm1 md1>
          </v-flex> -->

        <v-flex xs12 md4>
            <h2>Destination Address</h2>
            <gmap-autocomplete
            style="width: 300px; height: 40px; padding-right: 20px"
            placeholder="Destination Address Required"
            autofocus
              @place_changed="setPlace">
            </gmap-autocomplete>
            <div class="text-xs-center">
              <v-btn primary   @click="addMarker" color="green">
              Set Destination
              </v-btn>
            </div>
          </v-flex>

          <!-- <v-flex xs4 sm1 md1>
          </v-flex> -->
          
          
          <v-flex xs12 md4 v-if="!!booking">
            <span style="font-size: 16px; font-weight: bold" >Distance: </span><span >{{booking.distance}}</span><br>
            <span style="font-size: 16px; font-weight: bold" >Duration: </span><span >{{booking.duration}}</span><br>
            <span style="font-size: 16px; font-weight: bold" >Origin Address: </span><span >{{booking.originAddresses}}</span><br>
            <span style="font-size: 16px; font-weight: bold" >Destination Address: </span><span >{{booking.destinationAddresses}}</span><br>
          <v-alert
            :value="true"
            type="info"
            outline
            v-if="driver && diverMatrix"> 
            <span >Rate Your Driver: </span><v-rating x-large style="margin: 0;" @change="ratingChange()" v-model="rating"></v-rating>
          </v-alert>
          </v-flex>
         </v-card-title>
         
         <v-card-actions >
             <v-flex xs4 sm1 md1></v-flex>
            <v-flex xs12 sm6 md3>
              <v-text-field prepend-icon="person" v-model="user.fullname" name="fullname" label="Full Name" type="text"></v-text-field>
            </v-flex>
            <v-flex xs4 sm1 md1></v-flex>
            <v-flex xs12 sm6 md3>
              <v-text-field prepend-icon="phone" v-model="user.phone" name="phone" label="Mobile Number" type="text"></v-text-field>
            </v-flex>
             <v-flex xs4 sm1 md1></v-flex>
            <v-btn @click="bookTaxi" large color="info">Book Now</v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-app>
</template>

<script>
//import VuetifyGoogleAutocomplete from 'vuetify-google-autocomplete'
// import
export default {
  name: "GoogleMap",
  data() {
    return {
      // default to Tartu to keep it simple
      places: [],
      destinationPlace: null,
      currentPlace: null
      
    };
  },
 computed:{
      booking() {
        return this.$store.getters.booking;
      },
      rating() {
        return this.$store.getters.rating;
      },
      fullnamegetter(){
        return this.$store.getters.full_name;
      },
      rating: {
        // return this.$store.getters.full_name;
        get: function () {
          return this.initialRating
        },
        // setter
        set: function (newValue) {
          const newRateObject =
            {
              "rate": {
                "driver_id": this.driver.driver_id,
                "customer_rating": newValue
              }
            }
          this.$store.dispatch('pushRating', newRateObject); 
          // var names = newValue.split(' ')
          // this.firstName = names[0]
          // this.lastName = names[names.length - 1]
        }
      },
      initialRating(){
        return this.$store.getters.rating
      },
      driver(){
        return this.$store.getters.driver;
      },
      diverMatrix(){
        return this.$store.getters.driverMatrix;
      },
      phonegetter(){
        return this.$store.getters.phone;
      },
      user(){ return {
          fullname: this.fullnamegetter,
          phone: this.phonegetter
        }
      },
      pickupgetter(){
        return this.$store.getters.pickup;
      },
      destinationgetter(){
        return this.$store.getters.destination;
      },
      markers(){
        return[
          { position: this.pickupgetter },
          { position: this.destinationgetter }
        ]
      },
      center(){
        return this.$store.getters.pickup;
      },
      directionsService(){
         let newInstance = new google.maps.DirectionsService()
         let directionsDisplay = new google.maps.DirectionsRenderer()
        directionsDisplay.setMap(null)
        directionsDisplay.setMap(this.$refs.mapcanvas.$mapObject)
        newInstance.route(null)
         newInstance.route({
        origin: new google.maps.LatLng(this.markers[0].position.lat, this.markers[0].position.lng),
        destination: new google.maps.LatLng(this.markers[1].position.lat, this.markers[1].position.lng),
        travelMode: 'DRIVING'
        }, function (response, status) {
        if (status === 'OK') {
          directionsDisplay.setDirections(null)
          directionsDisplay.setDirections(response)
        } else {
          console.log('Directions request failed due to ' + status)
        }
      })
      }
   },
  mounted() {
    this.$store.dispatch('clearBooking')
    this.geolocate();
  },

  methods: {
    // receives a place object via the autocomplete component
    setPlace(place) {
      this.destinationPlace = place;
    },
    setCurrentPlace(place){
      this.currentPlace = place;
    },
    setPickupAddress(){
      if (this.currentPlace) {
         let center = {
          lat: this.currentPlace.geometry.location.lat(),
          lng: this.currentPlace.geometry.location.lng()
        };
        this.$store.dispatch('pickup', center)

        this.getRoute();
        this.getDistance();
       }

    },
    getDistance(){
      var service = new google.maps.DistanceMatrixService();
      service.getDistanceMatrix(
        {
        origins: [new google.maps.LatLng(this.markers[0].position.lat, this.markers[0].position.lng),],
        destinations: [new google.maps.LatLng(this.markers[1].position.lat, this.markers[1].position.lng),],
        travelMode: 'DRIVING'}, this.distanceMatrixCallBack);
    },
    distanceMatrixCallBack(response, status){
          this.$store.dispatch('setBookTripData', response);
          //this.bookingData = response
    },
    getRoute () {
      this.directionsService      
    },
    addMarker() {
      if (this.destinationPlace) {
        let destination  = {
          lat: this.destinationPlace.geometry.location.lat(),
          lng: this.destinationPlace.geometry.location.lng()
        };
        this.$store.dispatch('destination', destination)

        this.getRoute();
        this.getDistance();
      }
      //this.$store.dispatch('', this._data);
    },
    geolocate: function() {
      navigator.geolocation.getCurrentPosition(position => {
        let center = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        this.$store.dispatch('pickup', center)
        this.getAddress()
      });
    },
    getAddress(){
      let google_maps_geocoder = new google.maps.Geocoder();
      google_maps_geocoder.geocode(
          { 'latLng': this.center },
          ( results, status ) => {
              console.log( results );
              console.log(results[0].formatted_address)
              this.$store.dispatch('setBookerAddress', results[0].formatted_address); 
          }
      );
    },
    bookTaxi(){
      let bookinglatlng = { "booking": {
        req_lat: this.$store.getters.pickup.lat,
        req_long: this.$store.getters.pickup.lng,
        dest_lat: this.$store.getters.destination.lat,
        dest_long: this.$store.getters.destination.lng,
        customer_name: this.user.fullname,
        customer_mobile_number: this.user.phone,
        ...this.$store.getters.booking
      }};

      // let bookingPayload = {...bookinglatlng, ...this.$store.getters.booking};
     
      this.$store.dispatch('bookTrip', bookinglatlng); 
    },
    ratingChange(rating){
      console.log(rating)
        console.log(this.rating)
    }
  }
};
</script>