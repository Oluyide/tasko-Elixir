defmodule ApiExample.Models.StrMoneyManager do
  use Ecto.Schema
  import Ecto.Changeset


  schema "str_money_manager" do
    field :driver_id, :integer
    field :customer_id, :integer
    field :distance, :string
    field :ride_amt, :float
    field :driver_amount, :float
    field :str_amt, :float

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:driver_id, :customer_id, :ride_amt, :distance, :driver_amount, :str_amt])
    |> validate_required( [:driver_id, :customer_id, :ride_amt, :distance, :driver_amount, :str_amt])
  end
end
