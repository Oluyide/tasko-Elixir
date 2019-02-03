defmodule ApiExample.RoleTest do
  use ApiExample.DataCase

  alias ApiExample.Models.Role

  test "test changeset " do
    changeset = Role.changeset(%Role{}, %{name: "ismayil"})
    assert Keyword.has_key?([], [], :admin)

  end
end
