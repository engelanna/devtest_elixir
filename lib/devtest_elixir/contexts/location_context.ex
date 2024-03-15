defmodule DevtestElixir.Contexts.LocationContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country

  def locations_for_country_code(country_code) do
    query = (from country in Country,
            join: location_group in assoc(country, :location_groups),
            join: location in assoc(location_group, :locations),
            where: country.country_code == ^country_code,
            select: location)

    Repo.all(query)
  end
end
