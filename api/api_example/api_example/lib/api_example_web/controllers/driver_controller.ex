defmodule ApiExampleWeb.DriverController do
    use ApiExampleWeb, :controller


    alias ApiExample.Guardian
    alias ApiExample.Accounts
    alias ApiExample.Accounts.User
    alias ApiExample.Models.Driverlocation
    alias ApiExample.Repo
    alias ApiExample.Models.Booking
    alias ApiExample.Models.StrMoneyManager

    action_fallback ApiExampleWeb.FallbackController

    def ride_completed(conn,%{"booking" => ride_param}) do
        current_user = Guardian.Plug.current_resource(conn)
        extract_distance = String.split(ride_param["distance"], " ")
        {dist, ""} = Float.parse(Enum.at(extract_distance, 0))
        distance =
        case Enum.at(extract_distance, 1) do
            "km" ->  dist * 1000
            "m" -> dist
          end

          ride_cost = (distance * 0.98) / 1000
          driver_amount = 0.97 * ride_cost
          str_amount = 0.3 * ride_cost

          customer_wallet = Accounts.get_user!(ride_param["customer_id"])
          if(customer_wallet.wallet > ride_cost) do
          remain_wallet = customer_wallet.wallet - ride_cost
          wallet =  %{:wallet => remain_wallet}

        money_manager = %{:driver_id => current_user.id,
                          :customer_id => ride_param["customer_id"],
                          :distance => ride_param["distance"],
                          :ride_amt => ride_cost,
                          :driver_amount => driver_amount,
                          :str_amt => str_amount
                        }
        IO.puts("====================")
        IO.inspect(money_manager)
        IO.puts("====================")
        updateDriver_Info = Accounts.get_booking!(ride_param["id"])
        status =  %{:status => "completed"}


        with {:ok, %StrMoneyManager{} = _money} <- Accounts.settlement(money_manager),
             {:ok, %User{} = _money} <- Accounts.update_user_wallet(customer_wallet, wallet),
             {:ok, %Booking{} = _booking} <- Accounts.update_driverId_and_status(updateDriver_Info, status) do
        conn
        |> put_status(:ok)
        |> json(%{:driver_amount => driver_amount})
        end

    end
end

def update_locations(conn, %{"location_data"=> params}) do
        currentuser = Guardian.Plug.current_resource(conn)
        initial_driverdetails = Accounts.get_driver!(currentuser.id)
        params =
        params
          |> Map.put("driver_id", currentuser.id)
          |> Map.put("driver_lat_long", %Geo.Point{coordinates: {params["longitude"], params["latitude"]}, srid: 4326})
          IO.puts("======================")
          IO.inspect(params)
          IO.puts("======================")
        with {:ok, %Driverlocation{} = driver_location} <- Accounts.update_driver_location(initial_driverdetails, params) do
        render(conn, "success.json", driver_location: driver_location)
        end
end

    def update_status(conn, %{"location_data"=> params}) do
        currentuser = Guardian.Plug.current_resource(conn)
        initial_driverdetails = Accounts.get_driver!(currentuser.id)
        %{params | driver_id: currentuser.id}
        with {:ok, %Driverlocation{} = driver_location} <- Accounts.update_driver_location(initial_driverdetails, params) do
        render(conn, "success.json", driver_location: driver_location)
        end
    end

    def update_device_Id(conn, %{"location_data"=> params}) do
        currentuser = Guardian.Plug.current_resource(conn)
        initial_driverdetails = Accounts.get_driver!(currentuser.id)
        %{params | driver_id: currentuser.id}
        with {:ok, %Driverlocation{} = driver_location} <- Accounts.update_driver_location(initial_driverdetails, params) do
        render(conn, "success.json", driver_location: driver_location)
        end
    end

    def get_drivers_location(conn,%{}) do
        drivers = Accounts.list_drivers
        conn
        |> put_status(:ok)
        |> render("index.json", drivers: drivers)
      end

    def fectch_driver(conn, %{"driver_id" => driver_id}) do
        with {:ok, %Driverlocation{} = driver_location} <- Accounts.get_driver!(driver_id) do
        render(conn, "driver.json", driver_location: driver_location )
        end
    end

    # def update_req_Info_accepted(conn, %{"booking" => params}) do
    #     currentuser = Guardian.Plug.current_resource(conn)
    #     updateDriver_Info = Accounts.get_driver!(currentuser.id)
    #     params =
    #         params
    #     |> Map.put("driver_id", currentuser.id)
    #     |> Map.put("transaction_status","accepted")

    #     with {:ok, %Booking{} = booking} <- Accounts.update_driverId_and_status(updateDriver_Info, params) do
    #     render(conn, "success.json", booking: booking)
    #     end
    #   end

     def get_drivers_orders(conn, %{})do
        currentuser = Guardian.Plug.current_resource(conn)
        orders = Accounts.get_drivers_order!(currentuser.id) |> Repo.all
        if  (orders < 1) do
            conn |> render("noorder.json", orders: orders )
        else
        conn
        |> put_status(:ok)
        |> json(orders)
     end
    end
end
