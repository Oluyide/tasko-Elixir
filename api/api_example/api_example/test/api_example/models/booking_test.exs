defmodule ApiExample.BookingTest do
  use ApiExample.DataCase

  alias ApiExample.Models.Booking

  test "test changeset have all other fields" do
    changeset = Booking.changeset(%Booking{}, %{customer_id: 24})
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :transaction_status
  end

  test "test changeset driver mobile_number " do
    changeset = Booking.changeset(%Booking{}, %{customer_mobile_number: "some number"})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :transaction_status
  end
  test "test changeset driver customer_name" do
    changeset = Booking.changeset(%Booking{}, %{customer_name: "some name"})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :transaction_status
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
  end
  test "test changeset driver req_long" do
    changeset = Booking.changeset(%Booking{}, %{req_long: 124})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :transaction_status
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
  end
  test "test changeset driver req_lat" do
    changeset = Booking.changeset(%Booking{}, %{req_lat: 124})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :transaction_status
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
  end
  test "test changeset driver dest_long" do
    changeset = Booking.changeset(%Booking{}, %{dest_long: 124})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :transaction_status
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
  end
  test "test changeset driver dest_lat" do
    changeset = Booking.changeset(%Booking{}, %{dest_lat: 124})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :transaction_status
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
  end
  test "test changeset driver transaction_status" do
    changeset = Booking.changeset(%Booking{}, %{transaction_status: "some status"})
    assert Keyword.has_key? changeset.errors, :customer_id
    assert Keyword.has_key? changeset.errors, :driver_id
    assert Keyword.has_key? changeset.errors, :customer_name
    assert Keyword.has_key? changeset.errors, :req_long
    assert Keyword.has_key? changeset.errors, :req_lat
    assert Keyword.has_key? changeset.errors, :dest_long
    assert Keyword.has_key? changeset.errors, :dest_lat
    assert Keyword.has_key? changeset.errors, :customer_mobile_number
  end
end
