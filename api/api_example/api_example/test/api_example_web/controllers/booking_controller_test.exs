defmodule ApiExampleWeb.BookingControllerTest do
  use ApiExampleWeb.ConnCase

  alias ApiExample.Models
  alias ApiExample.Models.Booking
  alias ApiExample.Models.Driverlocation
  alias ApiExample.Accounts
  test "POST /book_a_car", %{conn: conn} do
    conn = post conn, "/api/v1/book_a_car", %{booking: [first_address: "Liivi 2", secoonf_address: "Lõunakeskus"]}
    assert response(conn, 401) =~ ~r/unauthenticated/
  end


end
