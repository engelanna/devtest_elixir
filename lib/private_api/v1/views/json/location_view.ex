defmodule PrivateAPI.V1.Views.JSON.LocationView do
  use PrivateAPI.V1.Views, :json_view

  def render("index.json", %{locations: locations}) do
    Enum.map(locations, &display/1)
  end

  def render("show.json", %{location: location}) do
    display(location)
  end


  defp display(location) do
    %{
      external_id: location.external_id,
      name: location.name
    }
  end
end
