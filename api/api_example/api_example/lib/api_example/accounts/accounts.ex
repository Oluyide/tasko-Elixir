defmodule ApiExample.Accounts do
  @moduledoc """
  The Accounts context.
  """
  alias ApiExample.Guardian
  import Ecto.Query, warn: false
  import Comeonin.Pbkdf2, only: [checkpw: 2, dummy_checkpw: 0]
  alias ApiExample.Repo

  alias ApiExample.Accounts.User
  alias ApiExample.Models.Role
  alias ApiExample.Models.Driverlocation
  alias ApiExample.Models.Booking
  alias ApiExample.Models.StrMoneyManager

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

  def list_users do
    Repo.all(User)
  end

  def list_roles do
    Repo.all(Role)
  end

  def list_drivers do
    Repo.all(Driverlocation)
  end
  # def list_available_drivers do
  #   query = from drivers in Driverlocation, where: drivers.status = "Available", select drivers.latitude
  #   Repo.all(query)
  # end
  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_role!(name), do: Repo.get_by(Role, name: name)

  def get_by_mail!(email), do: Repo.get_by(User, email: email)

  def get_driver!(driver_id), do: Repo.get_by(Driverlocation, driver_id: driver_id)

  def get_drivers_order!(driver_id) do
    #from(driver_loc in query, where: driver_loc.status == "Invisible", order_by: fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", driver_loc.driver_lat_long, ^lng, ^lat, ^srid))
    from orders in Booking, where: orders.driver_id == ^driver_id
   end
   def get_booking!(id), do: Repo.get!(Booking, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def create_driver_location(attrs \\ %{}) do
    % Driverlocation{}
    |> Driverlocation.changeset(attrs)
    |> Repo.insert()
  end

  def settlement(attrs \\ %{}) do
    % StrMoneyManager{}
    |> StrMoneyManager.changeset(attrs)
    |> Repo.insert()
  end


  def driver_within(query, point, radius_in_m) do
    lng = point["req_long"]
    lat = point["req_lat"]
    srid = 4326
    from(driver_loc in query, where: fragment("ST_DWithin(?::geography, ST_SetSRID(ST_MakePoint(?, ?), ?), ?)", driver_loc.driver_lat_long, ^lng, ^lat, ^srid, ^radius_in_m))
  end

  def order_driver_by_nearest(query, point) do
    lng = point["req_long"]
    lat = point["req_lat"]
    srid=4326
    from(driver_loc in query, where: driver_loc.status == "Available", order_by: fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", driver_loc.driver_lat_long, ^lng, ^lat, ^srid))
  end

  def order_driver_by_nearest_and_rejection_time(query, point, time) do
    lng = point["req_long"]
    lat = point["req_lat"]
    srid=4326
    from(driver_loc in query, where: driver_loc.status == "Available" and driver_loc.rejection_time < ^time or is_nil(driver_loc.rejection_time) , order_by: fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", driver_loc.driver_lat_long, ^lng, ^lat, ^srid))
  end

  def select_with_distance(query, point) do
    {lng, lat} = point.coordinates
    from(restaurant in query,
         select: %{restaurant | distance: fragment("ST_Distance_Sphere(?, ST_SetSRID(ST_MakePoint(?,?), ?))", restaurant.point, ^lng, ^lat, ^point.srid)})
  end
  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user_wallet(%User{} = user, attrs) do
    user
    |> User.wallet_changeset(attrs)
    |> Repo.update()
  end


  def update_driver_location(%Driverlocation{} = location, attrs) do
    location
    |> Driverlocation.changeset(attrs)
    |> Repo.update()
  end

  def update_driverId_and_status(%Booking{} = updateInfo, attrs) do
    updateInfo
    |> Booking.changeset(attrs)
    |> Repo.update()
  end
  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
