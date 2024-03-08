defmodule DevtestElixir.Contexts.TargetGroupContext do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup

  def root?(target_group_id) do
    with target_group <- Repo.get!(TargetGroup, target_group_id) do
      !target_group.parent_id
    end
  end
end
