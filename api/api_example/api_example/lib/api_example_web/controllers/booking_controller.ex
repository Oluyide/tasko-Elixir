defmodule ApiExampleWeb.BookingController do
  use ApiExampleWeb, :controller
  use PhoenixSwagger


  alias ApiExample.Models
  alias ApiExample.Models.Booking
  alias ApiExample.Guardian
  alias ApiExample.Accounts
  alias ApiExample.RoleChecker
  alias ApiExample.Models.Driverlocation
  alias ApiExample.Repo
  alias ApiExample.Accounts.User

  action_fallback ApiExampleWeb.FallbackController

  def wallet(conn, %{"wallet" => money_params}) do
    currentuser = Guardian.Plug.current_resource(conn)
    case RoleChecker.is_customer?(currentuser) do
      true ->
        user_details = Accounts.get_user!(currentuser.id)
        with {:ok, %User{} = _user} <- Accounts.update_user(user_details, money_params) do
          conn
        |> put_status(:ok)
        |> json("You have:"<> Float.to_string(money_params["amount"]))
        end
        false ->
          conn
          |> put_status(:unauthorized)
          |> render("failure.json", currentuser: currentuser)
        end
  end

  def index(conn, _params) do
    bookings = Models.list_bookings()
    render(conn, "index.json", bookings: bookings)
  end

  def rate_a_driver(conn, %{"rate" => rate_params}) do
    currentuser = Guardian.Plug.current_resource(conn)
    case RoleChecker.is_customer?(currentuser) do
      true ->
        initial_driverdetails = Accounts.get_driver!(rate_params["driver_id"])

        new_totalrating =  initial_driverdetails.number_who_rated + 1
        most_call = initial_driverdetails.number_who_rated * initial_driverdetails.average_rating + rate_params["customer_rating"]
        new_rating = (most_call / new_totalrating)
        rate_params =
          rate_params
            |> Map.put("id", initial_driverdetails.id)
            |> Map.put("average_rating", new_rating)
            |> Map.put("number_who_rated", new_totalrating)
        with {:ok, %Driverlocation{} = _driver_location} <- Accounts.update_driver_location(initial_driverdetails, rate_params) do

        conn
        |> put_status(:ok)
        |> json(rate_params["average_rating"])
        end
        false ->
          conn
          |> put_status(:unauthorized)
          |> render("failure.json", currentuser: currentuser)
      end
  end

  def create_booking(conn, %{"booking" => booking_params}) do
    currentuser = Guardian.Plug.current_resource(conn)
    case RoleChecker.is_customer?(currentuser) do
      true ->
             driverlist = Accounts.driver_within(Driverlocation, booking_params, 5000) |> Accounts.order_driver_by_nearest(booking_params)|> Repo.all
             counteryla = length(driverlist)
            if  (counteryla < 1) do
                conn |> render("nodriver.json", driverlist: driverlist )
            else
              driver = List.first(driverlist)
              driver_user = Accounts.get_user!(driver.driver_id)
              booking_params = booking_params
                      |> Map.put("customer_id", currentuser.id)
                      |> Map.put("driver_id", driver.driver_id)
                      |> Map.put("transaction_status", "requesting")
              extract_distance = String.split(booking_params["distance"], " ")
              b = List.first(extract_distance)
              #a = Integer.parse(Enum.at(extract_distance, 0))
              IO.puts("===================")
              IO.inspect(b)
              IO.puts("===================")
              {dist, ""} = Float.parse(Enum.at(extract_distance, 0))
              distance =
              case Enum.at(extract_distance, 1) do
                "km" ->  dist * 1000
                "m" -> dist
              end
              ride_cost = (distance * 0.98) / 1000
              driver =
                driver
                |> Map.put("ride_cost", ride_cost)
              with {:ok, %Booking{} = _booking} <- Models.create_booking(booking_params),
               {:ok, _body} = Fcmex.push(driver_user.device_id,notification: %{title: "taxi-str",body: "A new customer is waiting for you at"<> booking_params["originAddresses"] ,click_action: "open",icon: "new",}) do
              #{:ok, sms} = SmsBlitz.send_sms(:twilio, from: "Str", to: driver.driver_mobile_num, message: "A new customer is waiting for you at"<> booking_params["originAddresses"]) do

              conn
               |> put_status(:created)
               |> json(driver)
        end
      end
    false ->
      conn
      |> put_status(:unauthorized)
      |> render("failure.json", currentuser: currentuser)
  end
end


def update_req_Info_accepted(conn, %{"booking" => params}) do
  currentuser = Guardian.Plug.current_resource(conn)
  updateDriver_Info = Accounts.get_booking!(params["id"])

  params = params |> Map.put("transaction_status","accepted")

  with {:ok, %Booking{} = booking} <- Accounts.update_driverId_and_status(updateDriver_Info, params) do
    #customer_user = Accounts.get_user!(updateDriver_Info.customer_id)
    #{:ok, _body} = Fcmex.push(customer_user.device_id,notification: %{title: "taxi-str",body: "Your ride order has been accepted" ,click_action: "open",icon: "new",})
    #{:ok, _sms} = SmsBlitz.send_sms(:twilio, from: "Str", to: updateDriver_Info.customer_id.customer_mobile_number, message: "Your driver is on its way!")
  render(conn, "success.json", booking: booking)
  end
end

def update_req_Info_ride(conn, %{"driverData"=> params}) do
  currentuser = Guardian.Plug.current_resource(conn)
  updateDriver_Info = Accounts.get_driver!(currentuser.id)

  params = params|> Map.put("driver_id", currentuser.id)
                 |> Map.put("transaction_status","Ride")


  with {:ok, %Booking{} = booking} <- Accounts.update_driverId_and_status( updateDriver_Info, params) do
    customer_user = Accounts.get_user!(booking.customer_id)
    {:ok, _body} = Fcmex.push(customer_user.device_id,notification: %{title: "taxi-str",body: "Your ride order has been accepted" ,click_action: "open",icon: "new",})
  render(conn, "success.json", booking: booking)
  end
end


def update_req_Info_finish(conn, %{"driverData"=> params}) do
  currentuser = Guardian.Plug.current_resource(conn)
  updateDriver_Info = Accounts.get_driver!(currentuser.id)

  params = params|> Map.put("driver_id", currentuser.id)
                 |> Map.put("transaction_status","Finish")

  with {:ok, %Booking{} = booking} <- Accounts.update_driverId_and_status( updateDriver_Info, params) do
    customer_user = Accounts.get_user!(booking.customer_id)
    {:ok, _body} = Fcmex.push(customer_user.device_id,notification: %{title: "taxi-str",body: "Your ride order has been accepted" ,click_action: "open",icon: "new",})
  render(conn, "success.json", booking: booking)
  end
end

def order_declined(conn, %{"booking"=> params}) do
  currentuser = Guardian.Plug.current_resource(conn)
  updateDriver_Info = Accounts.get_booking!(params["id"])

  params = params |> Map.put("transaction_status", "Declined")
  driverlist = Accounts.driver_within(Driverlocation, params, 7000) |> Accounts.order_driver_by_nearest(params)|> Repo.all
  with {:ok, %Booking{} = booking} <- Accounts.update_driverId_and_status( updateDriver_Info, params) do
    customer_user = Accounts.get_user!(booking.customer_id)
    {:ok, _body} = Fcmex.push(customer_user.device_id,notification: %{title: "taxi-str",body: "Your ride order has been Declined we have provided you with a new driver" ,click_action: "open",icon: "new",})
    new_driver = Enum.take_random(driverlist, 1)
    counteryla = length(new_driver)
            if  (counteryla < 1) do
              conn |> render("nodriver.json", driverlist: driverlist )
            end
     conn
     |> put_status(:ok)
     |> json(new_driver)
  end
end

  def show(conn, %{"id" => id}) do
    booking = Models.get_booking!(id)
    render(conn, "show.json", booking: booking)
  end

  def update(conn, %{"id" => id, "booking" => booking_params}) do
    booking = Models.get_booking!(id)

    with {:ok, %Booking{} = booking} <- Models.update_booking(booking, booking_params) do
      render(conn, "show.json", booking: booking)
    end
  end

  def delete(conn, %{"id" => id}) do
    booking = Models.get_booking!(id)
    with {:ok, %Booking{}} <- Models.delete_booking(booking) do
      send_resp(conn, :no_content, "")
    end
  end
end
