defmodule DevtestElixir.Contexts.LocationGroupContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.LocationGroup

  def location_groups_for_country_id_and_panel_provider_id(country_id, panel_provider_id) do

    query = from location_group in LocationGroup,
            where: (
              location_group.country_id == ^country_id and
              location_group.panel_provider_id == ^panel_provider_id
            )

    Repo.all(query)
  end
end
