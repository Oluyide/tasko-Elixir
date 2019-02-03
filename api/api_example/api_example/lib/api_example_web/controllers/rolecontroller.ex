defmodule ApiExampleWeb.RoleController do
    use ApiExampleWeb, :controller
    use PhoenixSwagger

    alias ApiExample.Guardian
    alias ApiExample.Accounts
    alias ApiExample.Models.Role
    alias ApiExample.RoleChecker


    def create_role(conn, %{"role"=> roles_params}) do
      currentuser = RoleChecker.is_admin?(Guardian.Plug.current_resource(conn))
      if currentuser do
      role = Accounts.get_role!(roles_params["name"])
      if role do
      conn |> put_status(:not_found)
           |>render("failure.json", role: role )
       else
        with {:ok, %Role{} = role} <- Accounts.create_role(roles_params) do
          conn
          |> put_status(:created)
          |> render("success.json", role: role)
      end
    end
  else conn
  |> put_status(:unauthorized)
  |> render("unauthorized.json", currentuser: currentuser )
  end
end

def get_roles(conn,%{}) do
  roles = Accounts.list_roles
  conn
  |> put_status(:ok)
  |> render("index.json", roles: roles)
end
end
