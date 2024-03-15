defmodule Test.Support.Factories.LocationFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Location
  alias Faker.Address

  def create(opts \\ %{}) do
    changeset(opts)
    |> Repo.insert()
    |> elem(1)
  end

  def changeset(opts \\ %{}) do
    %Location{}
    |> Location.changeset(
      Map.merge(
        %{
          name: Address.city(),
          secret_code: "I'm invisible in your database"
        },
        opts
      )
    )
  end
end
