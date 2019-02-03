# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApiExample.Repo.insert!(%ApiExample.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ApiExample.Accounts


roles = [
    %{
      name: "Customer",
      admin: false
    },
    %{
        name: "Driver",
        admin: false
    },
    %{
        name: "Admin",
        admin: true
    },
    %{
        name: "Operator",
        admin: false
    }
  ]
Enum.each(roles, fn(data) ->
Accounts.create_role(data)
  end)



  user_params =[
  %{
		full_name: "driver1",
		email: "driver1@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
	},
    %{
		full_name: "driver2",
		email: "driver2@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
	},

    %{
		full_name: "driver3",
		email: "driver3@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
    },
    %{
		full_name: "driver4",
		email: "driver1@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
    },
    %{
		full_name: "driver5",
		email: "driver5@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
    },
    %{
		full_name: "driver6",
		email: "driver6@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
    },
    %{
		full_name: "driver7",
		email: "driver7@bar.com",
		mobile_number: "09023456789",
		password: "somePassword",
		password_confirmation: "somePassword",
		role_id: 2
    }]

    Enum.each(user_params, fn(data) ->
        Accounts.create_user(data)
      end)

    locations = [
        %{driver_id: 1, driver_name: "driver1", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-87.9074701, 43.0387105}, srid: 4326}, status: "Available", average_rating: 0.0, number_who_rated: 0},
        %{driver_id: 2, driver_name: "driver2", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-87.9082446, 43.0372896}, srid: 4326}, status: "Available", average_rating: 0.0, number_who_rated: 0 },
        %{driver_id: 3, driver_name: "driver3", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-87.9091676, 43.035253}, srid: 4326}, status: "Available", average_rating: 0.0, number_who_rated: 0 },
        %{driver_id: 4, driver_name: "driver4", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-87.9033059, 43.0020021}, srid: 4326}, status: "Available", average_rating: 0.0, number_who_rated: 0 },
        %{driver_id: 5, driver_name: "driver5", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-0.0000000, 0.0000000}, srid: 4326}, status: "Invisible", average_rating: 0.0, number_who_rated: 0 },
        %{driver_id: 6, driver_name: "driver6", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-0.0000000, 0.0000000}, srid: 4326}, status: "Invisible", average_rating: 0.0, number_who_rated: 0 },
        %{driver_id: 7, driver_name: "driver7", driver_mobile_num: 09023456789, watch_id: 0, driver_lat_long: %Geo.Point{coordinates: {-0.0000000, 0.0000000}, srid: 4326}, status: "Invisible", average_rating: 0.0, number_who_rated: 0 }
    ]

    Enum.each(locations, fn(data) ->
        Accounts.create_driver_location(data)
      end)


#   restaurant_params = [
#     %{name: "Alem Ethiopian Village", point: %Geo.Point{coordinates: {-87.9074701, 43.0387105}, srid: 4326}},
#     %{name: "Swingin' Door Exchange", point: %Geo.Point{coordinates: {-87.9082446, 43.0372896}, srid: 4326}},
#     %{name: "Milwaukee Public Market", point: %Geo.Point{coordinates: {-87.9091676, 43.035253}, srid: 4326}}
#     %{name: "Odd Duck", point: %Geo.Point{coordinates: {-87.9033059, 43.0020021}, srid: 4326}}
#   ]

#   Enum.each(restaurant_params, fn(params) ->
#     LocationBasedSearching.Restaurant.changeset(%LocationBasedSearching.Restaurant{}, params)
#     |> LocationBasedSearching.Repo.insert!()
#   end)

