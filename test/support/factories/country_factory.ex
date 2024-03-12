defmodule Test.Support.Factories.CountryFactory do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias Faker.Address
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country

  def changeset do
    %Country{}
    |> Country.changeset(%{country_code: generate_unique_country_code()})
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
