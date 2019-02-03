defmodule ApiExample.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :full_name, :string
    field :email, :string
    field :mobile_number, :string
    field :password_hash, :string
    field :wallet, :float
    field :device_id, :string

    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    belongs_to :role, ApiExample.Models.Role

    timestamps()
  end

  @doc false
  def changeset(struct, params \\%{}) do
    struct
    |> cast(params, [:full_name, :email, :mobile_number, :wallet, :device_id, :password, :password_confirmation, :role_id]) # Remove hash, add pw + pw confirmation
    |> validate_required([:full_name, :email, :mobile_number, :wallet, :device_id, :password, :password_confirmation, :role_id]) # Remove hash, add pw + pw confirmation
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 8) # Check that password length is >= 8
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email)
    |> put_password_hash
  end

  def wallet_changeset(struct, params \\%{}) do
    struct
    |> cast(params, [:wallet]) # Remove hash, add pw + pw confirmation
    |> validate_required([:wallet]) # Remove hash, add pw + pw confirmation

  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
          changeset
    end
  end
end
