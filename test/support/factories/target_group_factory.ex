defmodule Test.Support.Factories.TargetGroupFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup

  def create(opts \\ %{}) do
    changeset(opts)
    |> Repo.insert()
    |> elem(1)
  end

  def changeset(opts \\ %{}) do
    %TargetGroup{}
    |> TargetGroup.changeset(
      Map.merge(
        %{
          external_id: Ecto.UUID.generate(),
          name: "does not matter",
          secret_code: "does not matter"
        },
        opts
    ))
  end
end
