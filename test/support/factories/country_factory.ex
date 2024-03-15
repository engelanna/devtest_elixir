defmodule Test.Support.Factories.CountryFactory do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country
  alias Faker.Address

  def create(opts \\ %{}) do
    changeset(opts)
    |> Repo.insert()
    |> elem(1)
  end

  def changeset(opts \\ %{}) do
    %Country{}
    |> Country.changeset(
      Map.merge(
        %{country_code: generate_unique_country_code()},
        opts
      )
    )
  end


  defp generate_unique_country_code do
    unique_country_code = Address.country_code()
    existing_codes = Repo.all(from(c in Country, select: c.country_code))

    if unique_country_code in existing_codes do
      generate_unique_country_code()
    else
      unique_country_code
    end
  end
end
