defmodule ApiExampleWeb.UserControllerTest do
  use ApiExampleWeb.ConnCase
 alias ApiExample.Accounts
 alias ApiExample.Accounts.User
 test "index/2 responds with all Users", %{conn: conn} do

  users = [%{full_name: "John", email: "john@example.com",  mobile_number: "john mob",password: "somePassword", password_confirmation: "somePassword", role_id: 2, wallet: 123.5,device_id: "some"},
           %{full_name: "Jane", email: "jane@example.com", mobile_number: "john mob",password: "somePassword", password_confirmation: "somePassword", role_id: 2, wallet: 123.5,device_id: "some"}]

  # create users local to this database connection and test
  [{:ok, user1},{:ok, user2}] = Enum.map(users, &Accounts.create_user(&1))

  response =
    conn
    |> get(Routes.user_path(conn, :index))
    |> json_response(200)

  expected = %{
    "data" => [
      %{ "id" => user1.id,"email" => user1.email, "password_hash" => user1.password_hash},
      %{ "id" => user2.id,"email" => user2.email, "password_hash" => user2.password_hash }
    ]
  }

  assert response == expected
end
 test "Responds with user info if the user is found", %{conn: conn} do
  {:ok, user} = Accounts.create_user(%{full_name: "John", email: "foorunesausru@bar.com", mobile_number: "john mob",password: "somePassword", password_confirmation: "somePassword", role_id: 2, wallet: 123.5,device_id: "some"})

  response =
    conn
    |> get(Routes.user_path(conn, :show, user.id))
    |> response(200)

  expected = %{"data" => %{"id" => user.id,"email" => user.email, "password_hash" => user.password_hash}}


  assert response == expected
end
describe "User.changeset" do
  @invalid_attrs %{}


  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)

    refute changeset.valid?
  end
end
end
