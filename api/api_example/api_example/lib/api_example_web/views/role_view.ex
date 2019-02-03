defmodule ApiExampleWeb.RoleView do
    use ApiExampleWeb, :view
    alias ApiExampleWeb.RoleView

  def render("index.json", %{roles: roles}) do
      %{data: render_many(roles, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{
      id: role.id,
      name: role.name
    }
  end

  # def render("role.json", %{role: role}) do
  #   %{data:  render_one(role, RoleView, "role.json")}
  # end

  def render("success.json", %{role: _role}) do
    %{
      status: :ok,
      message: """
        Role created sucessfully
      """
    }
  end

  def render("failure.json", %{role: _role}) do
    %{
      status: :forbidden,
      message: """
        Role already exist
      """
    }
  end

  def render("unauthorized.json", %{currentuser: _currentuser}) do
    %{
      status: :forbidden,
      message: """
       unauthorized
      """
    }
  end
end
