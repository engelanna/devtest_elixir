defmodule DevtestElixir.Contexts.LocationContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Contexts.CountryContext
  alias DevtestElixir.Contexts.LocationGroupContext
  alias DevtestElixir.Schemas.Location

  def locations_for_country_code_based_on_current_panel_provider(country_code) do
    {
      :ok,
      %{
        id: country_id,
        panel_provider_id: panel_provider_id
      } = CountryContext.country_having_country_code(country_code)
    }

    location_group_ids_matching_country_and_panel_provider = Enum.map(
      LocationGroupContext.location_groups_for_country_id_and_panel_provider_id(country_id, panel_provider_id),
      fn record -> record.id end
    )

    Repo.all(
      from location in Location,
      join: location_group in assoc(location, :location_groups),
      where: location_group.id in ^location_group_ids_matching_country_and_panel_provider
    )
  end
end
