defmodule ApiExample.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string
      add :mobile_number, :string
      add :email, :string
      add :password_hash, :string
      add :wallet, :float
      add :device_id, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
