defmodule ApiExample.Repo.Migrations.AlterBookingTable do
  use Ecto.Migration

  def up do
    #execute "CREATE EXTENSION IF NOT EXISTS postgis"
    create table(:bookings) do
      add :customer_id, :integer
      add :customer_name, :string
      add :customer_mobile_number, :string
      add :driver_id, :integer
      add :req_long, :float
      add :req_lat, :float
      add :dest_long,  :float
      add :dest_lat,  :float
      add :transaction_status, :string
      add :originAddresses, :string
      add :destinationAddresses, :string

      timestamps()
  end
  # execute("SELECT AddGeometryColumn ('bookings','req_long_lat',4326,'POINT',2)")
  # execute("SELECT AddGeometryColumn ('bookings','dest_long_lat',4326,'POINT',2)")
  # execute("CREATE INDEX bookings_req_long_lat_index on bookings USING gist (req_long_lat)")
  # execute("CREATE INDEX bookings_dest_long_lat_index on bookings USING gist (dest_long_lat)")
end

def down do
  drop table(:bookings)
  execute "DROP EXTENSION IF EXISTS postgis"
end
end
