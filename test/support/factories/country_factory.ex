defmodule Test.Support.Factories.CountryFactory do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country
  alias Faker.Address
  alias Ecto.Changeset

  def create(opts \\ %{}) do
    changeset(opts)
    |> Changeset.put_assoc(:target_groups, opts[:target_groups] || [])
    |> Repo.insert!()
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
