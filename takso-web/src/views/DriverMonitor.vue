<template>
  <v-app id="inspire">
    <v-layout>
      <v-flex xs12 sm12 >
        <v-card>
        
         <v-container fill-height fluid>
              <v-layout fill-height>
                <v-flex xs12 align-end flexbox>
                  <span class="headline">Driver Status</span>
                  <v-flex xs12 sm6 d-flex>
                    <v-select
                      :items="items"
                      label="Change Status"
                      outline
                      v-model="status"
                      @change="onStatusChange"
                    ></v-select>
                  </v-flex>
                </v-flex>
              </v-layout>
            </v-container>
          <v-card-actions>
            <v-btn @click="refresh" x-large color="primary">Refresh Request</v-btn>
          </v-card-actions>
          <v-card-title>
            <v-data-table
                :headers="headers"
                :items="requests"
                class="elevation-1"
              >
                <template slot="items" slot-scope="props">
                  <td >{{ props.item.originAddresses }}</td>
                  <td >{{ props.item.destinationAddresses }}</td>
                  <td >{{ props.item.customer_mobile_number }}</td>
                  <td class="text-xs-right">
                    <v-btn v-if="props.item.transaction_status === 'accepted'" @click="acceptRequest(props.item.id)" color="success">Accept</v-btn>
                    <v-btn v-if="props.item.transaction_status === 'requesting'" @click="acceptRequest(props.item.id)" color="success">Accept</v-btn>
                    <v-btn v-if="props.item.transaction_status === 'requesting'" @click="rejectRequest(props.item.id)" color="error">Reject</v-btn>
                  </td>
                </template>
              </v-data-table>
            
          </v-card-title>
       
        </v-card>
      </v-flex>
    </v-layout>
  </v-app>

</template>

<script>
  export default {
    data() {
        return {
          items: [ "Off-duty", "Available", "Busy", "Invisible"],
        headers: [
        {
          text: 'From',
          align: 'left',
          sortable: false,
          value: 'destinationAddresses'
        },
        { text: 'To', sortable: false, value: 'originAddresses' },
        { text: 'Customer\'s Phone', sortable: false, value: 'customer_mobile_number' },        
        { text: ' ',  sortable: false, value: '' }
       ]
      }
    },
    computed:{
      status() {
        return this.$store.getters.status;
      },
      requests(){
        return this.$store.getters.requests;
      }
    },
    mounted() {
        this.geolocationWatching();
       
    },
    methods: {
        onStatusChange(newstatus) {
            let status = {
                    "location_data": {
                    "status": newstatus
                    }}; 
            this.$store.dispatch('changeStatus', status);
           
        },
        refresh(){
          this.$store.dispatch('refreshRequest'); 
        },
        acceptRequest(id){
          let idObject = {
                          "booking": {
    	                    "id": id
                          }  }
          this.$store.dispatch('acceptRequest', idObject); 
        },
        rejectRequest(id){
          let idObjects = {
                            "booking": {
                            "id": id
                            }
                          }  
           this.$store.dispatch('rejectRequest', idObjects); 
        },
        journeyComplete(id){
          let idObjects = {
                            "booking": {
                            "id": id
                            }
                          }  
           this.$store.dispatch('journeyComplete', idObjects); 
        },
        geolocationWatching(){
        navigator.geolocation.watchPosition(position => {
          this.$store.dispatch('driverLocation', 
                  {
                      "location_data": {
                      "longitude": position.coords.longitude,
                      "latitude": position.coords.latitude
                    }
                  } ); 
          }, (error) => {
            alert(error);
          }, {
          enableHighAccuracy: true,
          timeout: 7000,
        });
    }
   }
  }
</script>