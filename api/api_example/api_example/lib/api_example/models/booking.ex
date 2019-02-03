defmodule ApiExample.Models.Booking do
  use Ecto.Schema
  import Ecto.Changeset


  schema "bookings" do
    field :customer_id, :integer
    field :customer_name, :string
    field :customer_mobile_number, :string
    field :driver_id , :integer
    field :req_long, :float
    field :req_lat, :float
    field :dest_long,  :float
    field :dest_lat,  :float
    field :transaction_status, :string
    field :originAddresses, :string
    field :destinationAddresses, :string

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:customer_id, :customer_name, :customer_mobile_number, :driver_id, :req_long, :req_lat, :dest_long, :dest_lat, :transaction_status, :originAddresses, :destinationAddresses])
    |> validate_required([:customer_id, :customer_name, :customer_mobile_number, :driver_id, :req_long, :req_lat, :dest_long, :dest_lat, :transaction_status, :originAddresses, :destinationAddresses])
  end
end
