defmodule ApiExampleWeb.UserController do
  use ApiExampleWeb, :controller

  alias ApiExample.Guardian
  alias ApiExample.Accounts
  alias ApiExample.Accounts.User



  action_fallback ApiExampleWeb.FallbackController

  def delete(conn, _params) do
    jwt = Guardian.Plug.current_token(conn)
    Guardian.revoke(jwt)
    logout_message = %{:log_out => "You are logout successfully"}
    conn
    |> put_status(200)
    |> json(logout_message)
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end


  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
          IO.inspect(user)
          driver_initloc = %{:driver_name => user.full_name,
                            :driver_mobile_num => user.mobile_number,
                            :driver_id => user.id,
                            :watch_id => 0,
                            :driver_lat_long => %Geo.Point{coordinates: {-00.0000000, 00.000000000}, srid: 4326},
                            :status => "Invisible",
                            :average_rating => 0.0,
                            :number_who_rated => 0,
                            :rejection_time => nil}


          case user_params["role_id"] do
            2 -> Accounts.create_driver_location(driver_initloc)
            _ -> "Any other users"
          end
       conn |> render("jwt.json", jwt: token)
    end
  end

  def update_device_Id(conn, %{"user" => user_params}) do
    currentuser = Guardian.Plug.current_resource(conn)
    initial = Accounts.get_user!(currentuser.id)
    with {:ok, %User{} = user} <- Accounts.update_user(initial, user_params) do
   conn
   |> put_status(:ok)
   |> json(user)
    end
end
  # booking_params = booking_params
  #                     |> Map.put("customer_id", currentuser.id)
  #                     |> Map.put("driver_id", -1)
  #                     |> Map.put("transaction_status", "requesting")


  def sign_in(conn, %{"email" => email, "password" => password}) do
     case Accounts.token_sign_in(email, password) do
       {:ok, token, _claims} ->

        user = Accounts.get_by_mail!(email)
        if (user.role_id == 2) do
         driver = Accounts.get_driver!(user.id)
         token_values =  %{:jwt => token, :full_name => user.full_name, :mobile_number => user.mobile_number, :role_id=> user.role_id, :status=> driver.status,  :wallet => user.wallet,
         :device_id => user.device_id}
         conn |> render("jwt.json", loggedin_user: token_values)
        else
          token_values =  %{:jwt => token, :full_name => user.full_name, :mobile_number => user.mobile_number, :role_id=> user.role_id, :wallet => user.wallet,
          :device_id => user.device_id}
         conn |> render("jwt.json", loggedin_user: token_values)
        end
       _ ->
         {:error, :unauthorized}
     end
   end
  # def sign_in(conn, %{"session" => %{"email" => email, "password" => password}}) do
  #   case Accounts.token_sign_in(email, password) do
  #     {:ok, user} ->
  #         {:ok, token, _claims} = Guardian.encode_and_sign(user, :api)
  #        conn
  #        |> render "sign_in.json", user: user, jwt: token
  #        _ ->
  #       {:error, :unauthorized}
  #   end
  # end
  # def create1(conn, %{"user" => user_params}) do
  #   with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", user_path(conn, :show, user))
  #     |> render("show.json", user: user)
  #   end
  # end

  def show1(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
 end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   with {:ok, %User{}} <- Accounts.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
