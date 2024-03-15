defmodule Test.Support.Factories.LocationGroupFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.LocationGroup
  alias Faker.Nato

  def create(opts \\ %{}) do
    changeset(opts)
    |> Repo.insert()
    |> elem(1)
  end

  def changeset(opts \\ %{}) do
    %LocationGroup{}
    |> LocationGroup.changeset(
      Map.merge(
        %{name: Nato.letter_code_word()},
        opts
      )
    )
  end
end
