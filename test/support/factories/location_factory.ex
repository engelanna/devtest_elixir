defmodule Test.Support.Factories.LocationFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Location
  alias Ecto.Changeset

  require Faker

  def create(opts \\ %{}) do
    changeset(opts)
    |> Changeset.put_assoc(:location_groups, opts[:location_groups] || [])
    |> Repo.insert!()
  end

  def changeset(opts \\ %{}) do
    %Location{}
    |> Location.changeset(
      Map.merge(
        %{
          name: Faker.Address.city(),
          secret_code: Faker.String.base64()
        },
        opts
      )
    )
  end
end
