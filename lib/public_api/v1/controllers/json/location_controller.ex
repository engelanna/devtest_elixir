defmodule PublicAPI.V1.Controllers.JSON.LocationController do
  @moduledoc false

  use PublicAPI.V1.Controllers, :json_controller

  alias DevtestElixir.Contexts.LocationContext

  def locations_for_country_code(conn, %{"country_code" => country_code}) do
    matched_locations = LocationContext.locations_for_country_code_based_on_countrys_panel_provider(country_code)

    render(conn, :index, locations: matched_locations)
  end

end
