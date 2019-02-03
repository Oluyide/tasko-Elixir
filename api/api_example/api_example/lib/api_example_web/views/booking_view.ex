defmodule ApiExampleWeb.BookingView do
  use ApiExampleWeb, :view
  alias ApiExampleWeb.BookingView

  def render("index.json", %{bookings: bookings}) do
    %{data: render_many(bookings, BookingView, "booking.json")}
  end

  def render("show.json", %{booking: booking}) do
    %{data: render_one(booking, BookingView, "booking.json")}
  end

  def render("driver.json", %{driver: driver}) do
    IO.puts "<<<<<<<<<<<<<<<<<<<<<"
    driver_lat_long = %{coordinates: driver.driver_lat_long.coordinates}
    IO.inspect driver_lat_long
    IO.puts "<<<<<<<<<<<<<<<<<<<<<"
    %{
      id: driver.id,
      driver_id: driver.driver_id,
      driver_name: driver.driver_name,
      driver_mobile_num: driver.driver_mobile_num,
      watch_id: driver.watch_id,
      driver_lat_long: driver_lat_long,
      status: driver.status
    }
  end

  def render("nodriver.json", %{driverlist: _driverlist}) do
    %{
    status: :ok,
      message: """
        No Driver available
      """
    }
  end

  def render("success.json", %{booking: _booking}) do
    %{
      status: :ok,
      message: """
       Your car is on its way
      """
    }
  end
  def render("failure.json", %{currentuser: _currentuser}) do
    %{
      status: :forbidden,
      message: """
        You must register as a customer to use this feature
      """
    }
  end
end
