defmodule Test.Support.Factories.TargetGroupFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup

  def create(parent_id \\ nil) do
    build(parent_id)
    |> Repo.insert()
  end

  def build(parent_id \\ nil) do
    %TargetGroup{}
    |> TargetGroup.changeset(
      %{
        parent_id: parent_id,
        external_id: Ecto.UUID.generate(),
        name: "does not matter",
        secret_code: "does not matter"
      }
    )
  end
end
