defmodule ApiExample.Models.Driverlocation do
  use Ecto.Schema
  import Ecto.Changeset


  schema "driver_location" do
    field :driver_id, :integer
    field :driver_name, :string
    field :driver_mobile_num, :string
    field :watch_id, :integer
    field :driver_lat_long,  Geo.PostGIS.Geometry
    field :status, :string
    field :average_rating, :float
    field :number_who_rated, :integer
    # field :rejection_time, :utc_datetime, null: true

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:driver_id, :driver_name, :driver_mobile_num, :watch_id, :driver_lat_long, :status, :average_rating, :number_who_rated])
    |> validate_required([:driver_id, :driver_name, :driver_mobile_num, :watch_id, :driver_lat_long, :status, :average_rating, :number_who_rated])
  end
end
