defmodule Test.Support.Factories.CountryFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country

  def create() do
    changeset()
    |> Repo.insert()
  end

  def changeset() do
    %Country{}
    |> Country.changeset(
      %{
        country_code: "PL"
      }
    )
  end
end
