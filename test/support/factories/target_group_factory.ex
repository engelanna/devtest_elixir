defmodule Test.Support.Factories.TargetGroupFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup
  alias Ecto.Changeset

  def create(opts \\ %{}) do
    changeset(opts)
    |> Changeset.put_assoc(:countries, opts[:countries] || [])
    |> Repo.insert!()
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
        Map.delete(opts, :countries)
    ))
  end
end
