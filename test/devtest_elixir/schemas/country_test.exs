defmodule Test.DevtestElixir.Schemas.CountryTest do
  use DevtestElixir.DataCase, async: true

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country
  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.TargetGroupFactory

  setup do
    {:ok, root_target_group} = TargetGroupFactory.create()
    {:ok, nonroot_target_group} = TargetGroupFactory.create(root_target_group.id)

    [
      country_linked_to_root: country_associated_with([root_target_group]),
      country_linked_to_nonroot: country_associated_with([nonroot_target_group]),
      country_linked_to_both: country_associated_with([root_target_group, nonroot_target_group])
    ]
  end


  test "should allow saving a Country associated with a root TargetGroup",
    %{country_linked_to_root: country_linked_to_root} do

    assert {:ok, _} = Repo.insert(country_linked_to_root)
  end

  test "should refuse saving a Country associated with a nonroot TargetGroup",
    %{country_linked_to_nonroot: country_linked_to_nonroot} do

    assert {:error, [{:target_groups, "All target groups must be root nodes (i.e. none of them may have a .parent_id"}]} = Repo.insert(country_linked_to_nonroot)
  end

  test "should refuse saving a Country associated with multiple TargetGroups some of which aren't root",
    %{country_linked_to_both: country_linked_to_both} do

    assert {:error, [{:target_groups, "All target groups must be root nodes (i.e. none of them may have a .parent_id"}]} = Repo.insert(country_linked_to_both)
  end

  defp country_associated_with(target_groups) do
    CountryFactory.changeset()
    |> Country.changeset(%{})
    |> put_assoc(:target_groups, target_groups)
  end
end
