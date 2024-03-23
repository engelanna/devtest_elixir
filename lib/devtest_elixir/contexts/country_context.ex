defmodule DevtestElixir.Contexts.CountryContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country

  def from_country_code_with_panel_provider(country_code) do
    Repo.one!(
      from country in Country,
        where: country.country_code == ^country_code,
        preload: :panel_provider
    )
  end
end
