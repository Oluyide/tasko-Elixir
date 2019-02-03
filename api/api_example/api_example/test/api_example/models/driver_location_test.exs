defmodule ApiExample.DriverLocationTest do
  use ApiExample.DataCase

  alias ApiExample.Models.Driverlocation

  test "test changeset driver id" do
    changeset = Driverlocation.changeset(%Driverlocation{}, %{driver_id: 24})
    assert Keyword.has_key? changeset.errors, :driver_name
    assert Keyword.has_key? changeset.errors, :driver_mobile_num
    assert Keyword.has_key? changeset.errors, :watch_id
    assert Keyword.has_key? changeset.errors, :driver_lat_long
    assert Keyword.has_key? changeset.errors, :status
    assert Keyword.has_key? changeset.errors, :average_rating
    assert Keyword.has_key? changeset.errors, :number_who_rated
  end
  test "test changeset rated" do
    changeset = Driverlocation.changeset(%Driverlocation{}, %{driver_mobile_num: "some mobile_number"})

    assert Keyword.has_key? changeset.errors, :number_who_rated

  end
  test "test changeset driver mob num" do
    changeset = Driverlocation.changeset(%Driverlocation{}, %{driver_id: 24})

    assert Keyword.has_key? changeset.errors, :driver_mobile_num

  end
  @valid_attrs %{ driver_name: "some name",driver_id: 24,  driver_mobile_num: "some mobile_number", status: "ok", watch_id: 124, driver_lat_long: 123 ,average_rating: 123.4 ,number_who_rated: 14}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Driverlocation.changeset(%Driverlocation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Driverlocation.changeset(%Driverlocation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
