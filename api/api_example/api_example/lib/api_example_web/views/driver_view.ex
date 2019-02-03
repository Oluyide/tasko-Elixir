defmodule ApiExampleWeb.DriverView do
    use ApiExampleWeb, :view
    alias ApiExampleWeb.DriverView

  def render("index.json", %{drivers: drivers}) do
      %{data: render_many(drivers, DriverView, "driver.json")}
  end

  def render("show.json", %{driver: driver}) do
    %{data: render_one(driver, DriverView, "driver.json")}
  end
  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, DriverView, "order.json")}
end

def render("order.json", %{order: order}) do
  %{
    id: order.id,
    customer_id: order.customer_id,
    customer_mobile_number: order.customer_mobile_number,
    req_lat: order.req_lat,
    req_long: order.req_long,
    dest_lat: order.dest_lat,
    dest_long: order.dest_long,
    status: order.status
  }

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

    def render("success.json", %{driver_location: _driver_location}) do
        %{
          status: :ok,
          message: """
            updated sucessfully
          """
        }
      end

      def render("driver.json", %{driver_location: driver_location}) do
        %{
          full_name: driver_location.full_name,
          watch_id: driver_location.watch_id,
		      longitude: driver_location.longitude,
		      latitude: driver_location.latitude,
          status: driver_location.status

        }
      end

      def render("noorder.json", %{orders: _orders }) do
        %{
          status: :ok,
          message: """
           No order for you at the moment
          """
        }
      end
end
