# defmodule Test.DevtestElixir.Schemas.TargetGroupTest do
#   use DevtestElixir.DataCase, async: true

#   alias DevtestElixir.Repo
#   alias DevtestElixir.Schemas.CountryTargetGroup
#   alias Test.Support.Factories.CountryFactory
#   alias Test.Support.Factories.TargetGroupFactory

#   setup do
#     {:ok, country} = CountryFactory.create()
#     {:ok, root_target_group} = TargetGroupFactory.create()
#     {:ok, nonroot_target_group} = TargetGroupFactory.create(root_target_group.id)

#     [country: country, root_target_group: root_target_group, nonroot_target_group: nonroot_target_group]
#   end

#   test "should save CountryTargetGroup when TargetGroup is root",
#     %{country: country, root_target_group: root_target_group} do

#     assert {:ok, _} = associate(country.id, root_target_group.id)
#   end

#   test "should refuse saving CountryTargetGroup when TargetGroup not root",
#     %{country: country, nonroot_target_group: nonroot_target_group} do

#     assert {:error, changeset} = associate(country.id, nonroot_target_group.id)
#     assert changeset.errors[:target_group_id] == {"must be a root node", []}
#   end


#   defp associate(country_id, target_group_id) do
#     %CountryTargetGroup{}
#     |> CountryTargetGroup.changeset(%{country_id: country_id, target_group_id: target_group_id})
#     |> Repo.insert()
#   end
# end
