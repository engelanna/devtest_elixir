defmodule Test.DevtestElixir.Schemas.TargetGroupTest do
  use Test.Support.DataCase, async: true

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup
  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.TargetGroupFactory

  setup do
    root_target_group = TargetGroupFactory.create()
    nonroot_target_group = TargetGroupFactory.create(%{parent_id: root_target_group.id})

    [
      root_target_group: target_group_changeset_with_country(root_target_group),
      nonroot_target_group: target_group_changeset_with_country(nonroot_target_group)
    ]
  end


  describe "INSERTing a TargetGroup" do
    test "when a root (no parent_id) TargetGroup has a Country associated",
      %{root_target_group: root_target_group} do

      assert {:ok, _} = Repo.update(root_target_group)
    end
  end

  describe "refusing to INSERT a TargetGroup" do
    test "when a nonroot (has parent_id) TargetGroup has a Country associated",
      %{nonroot_target_group: nonroot_target_group} do

      assert {:error, changeset} = Repo.update(nonroot_target_group)

      assert changeset.errors == [
        parent_id: {
          "Only root TargetGroups (those without .parent_id) may be associated with Countries",
          []
        }
      ]
    end
  end

  defp target_group_changeset_with_country(target_group_struct) do
    new_country_map = Map.from_struct(CountryFactory.create())

    TargetGroup.changeset(
      target_group_struct,
      %{countries: [new_country_map]}
    )
  end
end
