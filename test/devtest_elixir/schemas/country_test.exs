defmodule Test.DevtestElixir.Schemas.CountryTest do
  use Test.Support.DataCase, async: true

  alias DevtestElixir.Repo
  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.TargetGroupFactory

  setup do
    root_target_group = TargetGroupFactory.create()
    nonroot_target_group = TargetGroupFactory.create(%{parent_id: root_target_group.id})

    [
      country_linked_to_both: country_changeset_with_target_groups([root_target_group, nonroot_target_group]),
      country_linked_to_nonroot: country_changeset_with_target_groups([nonroot_target_group]),
      country_linked_to_root: country_changeset_with_target_groups([root_target_group])
    ]
  end


  describe "INSERTing a Country" do
    test "when associated with a root TargetGroup",
      %{country_linked_to_root: country_linked_to_root} do

      assert {:ok, _} = Repo.insert(country_linked_to_root)
    end
  end

  describe "refusing to INSERT a Country" do
    test "when associated with a nonroot TargetGroup",
      %{country_linked_to_nonroot: country_linked_to_nonroot} do

      assert {:error, result} = Repo.insert(country_linked_to_nonroot)

      assert List.first(result.changes.target_groups).errors == [
        parent_id: {
          "Only root TargetGroups (those without .parent_id) may be associated with Countries",
          []
        }
      ]
    end

    test "when associated with multiple TargetGroups some of which aren't root",
      %{country_linked_to_both: country_linked_to_both} do
        assert {:error, result} = Repo.insert(country_linked_to_both)

        assert Enum.map(result.changes.target_groups, fn tg -> tg.errors end) == [
          [],
          [
            parent_id: {
              "Only root TargetGroups (those without .parent_id) may be associated with Countries",
              []
            }
          ]
        ]
    end
  end


  defp country_changeset_with_target_groups(target_group_structs) do
    target_group_maps = Enum.map(target_group_structs, &Map.from_struct/1)

    CountryFactory.changeset(%{target_groups: target_group_maps})
  end
end
