defmodule ApiExample.Repo.Migrations.StrMoneyManager do
  use Ecto.Migration

  def change do
    create table(:str_money_manager) do
      add :driver_id, :integer
      add :customer_id, :integer
      add :distance, :string
      add :ride_amt, :float
      add :driver_amount, :float
      add :str_amt, :float

      timestamps()
  end
end
end
