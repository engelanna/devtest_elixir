defmodule DevtestElixir.Contexts.LocationContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Location

  def locations_for_country_code_based_on_countrys_panel_provider(country_code) do
    Repo.all(
      from location in Location,
        join: location_group in assoc(location, :location_groups),
        join: country in assoc(location_group, :country),
          on: location_group.panel_provider_id == country.panel_provider_id,
        where: country.country_code == ^country_code
    )
  end
end
