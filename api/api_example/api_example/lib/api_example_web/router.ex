defmodule ApiExampleWeb.Router do
  use ApiExampleWeb, :router

  alias ApiExample.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/", ApiExampleWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", ApiExampleWeb do
     pipe_through :api

    resources "/users", UserController, only: [:create, :show]
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    delete "/logout", UserController, :delete

    # post "/create_role", RoleController, :create_role
    # get  "/get_roles", RoleController, :get_roles
    #resources "/bookings", BookingController, except: [:new, :edit]
   end

   scope "/api/v1", ApiExampleWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/my_users", UserController, :show
    post "/create_role", RoleController, :create_role
    get  "/get_roles", RoleController, :get_roles

    get  "/get_drivers", DriverController, :get_drivers_location
    get  "/fetch_driver", DriverController, :fetch_driver
    get "/get_order_for_drivers", DriverController, :get_drivers_orders
    patch "/ride_complete", DriverController, :ride_completed
    patch "/update_driver_location", DriverController, :update_locations
    patch "/update_status", DriverController, :update_status

    patch "/rate_driver", BookingController, :rate_a_driver
    patch "/reject_order", BookingController, :order_declined
    patch "/add_to_customer_wallet", BookingController, :wallet
    get "/bookings/summary", BookingController, :summary
    post "/book_a_car", BookingController, :create_booking
    patch "/accept_order", BookingController, :update_req_Info_accepted


  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "STR",
        host: "localhost:4000"
      }
    }
  end

end
