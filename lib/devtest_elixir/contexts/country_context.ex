defmodule DevtestElixir.Contexts.CountryContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country

  def country_having_country_code(country_code) do
    Repo.one!(
      from c in Country,
      where: c.country_code == ^country_code,
      preload: [:panel_provider]
    )
  end
end
