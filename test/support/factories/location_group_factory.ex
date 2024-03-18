defmodule Test.Support.Factories.LocationGroupFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.LocationGroup
  alias Ecto.Changeset

  require Faker

  def create(opts \\ %{}) do
    changeset(opts)
    |> Changeset.put_assoc(:locations, opts[:locations] || [])
    |> Repo.insert()
    |> elem(1)
  end

  def changeset(opts \\ %{}) do
    %LocationGroup{}
    |> LocationGroup.changeset(
      Map.merge(
        %{name: Faker.Nato.letter_code_word()},
        opts
      )
    )
  end
end
