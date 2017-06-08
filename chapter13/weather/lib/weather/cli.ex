defmodule Weather.CLI do
  import SweetXml

  @elements ~w(
    suggested_pickup
    suggested_pickup_period
    location
    station_id
    latitude
    longitude
    observation_time
    observation_time_rfc822
    weather
    temperature_string
    temp_f
    temp_c
    relative_humidity
    wind_string
    wind_dir
    wind_degrees
    wind_mph
    wind_kt
    pressure_string
    pressure_mb
    pressure_in
    dewpoint_string
    dewpoint_f
    dewpoint_c
    visibility_mi
    icon_url_base
    two_day_history_url
    icon_url_name
    ob_url
    disclaimer_url
    copyright_url
    privacy_policy_url
  )

  @subspec Enum.map(@elements, &({&1, ~x".//#{&1}/text()"})) |> Enum.into([])

  def main(argv) do
    argv
    |> parse_args()
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv)
    case parse do
    {_, [airport], _} -> airport
    end
  end

  def process(airport) do
    url(airport)
    |> HTTPoison.get()
    |> handle_response()
    |> display
  end

  def url(airport) do
    "http://w1.weather.gov/xml/current_obs/#{airport}.xml"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    body
    |> xpath(~x"//current_observation", @subspec)
    |> Enum.into(%{})
  end

  def display(map) do
    map
    |> Enum.map(fn {k, v} -> :io.format("~30s  ~-30s~n", [k,v]) end)
  end
end
