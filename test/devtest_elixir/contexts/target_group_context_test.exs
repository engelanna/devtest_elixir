defmodule Test.DevtestElixir.Contexts.TargetGroupContextTest do
  use DevtestElixir.DataCase, async: true

  alias DevtestElixir.Contexts.TargetGroupContext
  alias Test.Support.Factories.TargetGroupFactory

  setup do
    {:ok, root_target_group} = TargetGroupFactory.create()
    {:ok, child_target_group} = TargetGroupFactory.create(root_target_group.id)

    [root_target_group: root_target_group, child_target_group: child_target_group]
  end

  test "should return true from .root? for a TargetGroup with no parent_id", %{root_target_group: root_target_group} do
    is_root = TargetGroupContext.root?(root_target_group.id)

    assert is_root == true
  end

  test "should return false from .root? for a TargetGroup with a parent_id",
    %{child_target_group: child_target_group} do

    is_root = TargetGroupContext.root?(child_target_group.id)

    assert is_root == false
  end
end