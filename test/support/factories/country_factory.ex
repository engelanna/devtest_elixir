defmodule Test.Support.Factories.CountryFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country

  def create() do
    build()
    |> Repo.insert()
  end

  def build() do
    %Country{}
    |> Country.changeset(
      %{
        country_code: "PL"
      }
    )
  end
end
