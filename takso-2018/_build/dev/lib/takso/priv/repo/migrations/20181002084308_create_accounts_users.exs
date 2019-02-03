defmodule Takso.Repo.Migrations.CreateAccountsUsers do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :name, :string
      add :username, :string
      add :password, :string

      timestamps()
    end

  end
end
