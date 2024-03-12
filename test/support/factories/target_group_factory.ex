defmodule Test.Support.Factories.TargetGroupFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup

  def create(parent_id \\ nil) do
    changeset(parent_id)
    |> Repo.insert()
    |> elem(1)
    |> Repo.preload(:countries)
  end

  defp changeset(parent_id) do
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
