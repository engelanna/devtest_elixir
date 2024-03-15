defmodule DevtestElixir.PrivateAPI.V1.Views.JSON.LocationView do
 use DevtestElixir.PrivateAPI.V1, :view

 def render("show.json", %{location: location}) do
    %{
      id: location.id,
      name: location.name,
      country_id: location.country_id,
      panel_provider_id: location.panel_provider_id,
      # Include other fields as needed
    }
 end
end
