defmodule DevtestElixir.Contexts.TargetGroupContextTest do
  use DevtestElixir.DataCase, async: true

  alias DevtestElixir.Contexts.TargetGroupContext
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup

  setup do
    {:ok, root_target_group} = create_target_group()
    {:ok, child_target_group} = create_target_group(root_target_group.id)

    [root_target_group: root_target_group, child_target_group: child_target_group]
  end

  test "should return true from .root? for a TargetGroup with no parent_id", %{root_target_group: root_target_group} do
    is_root = TargetGroupContext.root?(root_target_group.id)

    assert is_root == true
  end

  test "should return false from .root? for a TargetGroup with a parent_id", %{child_target_group: child_target_group} do
    is_root = TargetGroupContext.root?(child_target_group.id)

    assert is_root == false
  end


  defp create_target_group(parent_id \\ nil) do
    %TargetGroup{}
    |> TargetGroup.changeset(
      %{
        parent_id: parent_id,
        external_id: Ecto.UUID.generate(),
        name: "does not matter",
        secret_code: "does not matter"
      })
    |> Repo.insert()
  end
end
