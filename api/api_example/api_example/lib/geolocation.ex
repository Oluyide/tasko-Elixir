defmodule Geolocation do

defp process_address(address) do
  city = "Tartu"
  country = "Estonia"
  address
  |> String.replace(" ", "+")
  |> (&(&1 <> &2)).("+#{city}+#{country}")
end

def trip_duration(origin, destination) do

  origin = process_address(origin)
  destination = process_address(destination)

  %{body: body} = @http_client.get!(
      "https://maps.googleapis.com/maps/api/distancematrix/json?key=@gmaps_api_key&origins=#{origin}&destinations=#{destination}")
  %{"rows" => [%{"elements" => [%{"duration" => %{"text" => duration_text}}]}]} = Poison.Parser.parse!(body)
  duration_text
end

end

