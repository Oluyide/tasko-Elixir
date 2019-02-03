defmodule ApiExample.UserTest do
  use ApiExample.DataCase

  alias ApiExample.Accounts.User

  @valid_attrs %{full_name: "some name",email: "some@email.com", password: "some password", password_confirmation: "some password", mobile_number: "some mobile_number", role_id: 1, wallet: 123.5,device_id: "some"}
  @invalid_attrs %{}

  test " password less than 8 characters" do
    changeset = User.changeset(%User{}, %{@valid_attrs | password: "ismaa"})

    assert  %{
      password: ["should be at least 8 character(s)"],
      password_confirmation: ["does not match confirmation"]
    }
  end

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
