defmodule ApiExample.Repo.Migrations.CreatingDrivers do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"
    create table(:driver_location) do
      add :driver_id, :integer
      add :driver_name, :string
      add :driver_mobile_num, :string
      add :watch_id, :integer
      add :status, :string
      add :average_rating, :float
      add :number_who_rated, :integer
      # add :rejection_time, :utc_datetime, null: true

      timestamps()
  end
  execute("SELECT AddGeometryColumn ('driver_location','driver_lat_long',4326,'POINT',2)")
  execute("CREATE INDEX driver_location_driverlatlong_index on driver_location USING gist (driver_lat_long)")
end

def down do
  drop table(:driver_location)
  execute "DROP EXTENSION IF EXISTS postgis"
end
end

