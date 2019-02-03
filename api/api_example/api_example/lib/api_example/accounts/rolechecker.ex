defmodule ApiExample.RoleChecker do

  import Ecto.Query, warn: false

  alias ApiExample.Accounts

    def is_admin?(user) do
        userdetails = Accounts.get_user!(user.id)
        if (userdetails.role_id == 3) do
        true
        else false
     end
    end

    def is_customer?(user) do
        userdetails = Accounts.get_user!(user.id)
        if (userdetails.role_id == 1) do
        true
        else false
    end
end

    def is_driver?(user) do
        userdetails = Accounts.get_user!(user.id)
        if (userdetails.role_id == 2) do
        true
        else false
    end
end

    def is_operator?(user) do
        userdetails = Accounts.get_user!(user.id)
        if (userdetails.role_id == 4) do
        true
        else false
    end
  end
end
