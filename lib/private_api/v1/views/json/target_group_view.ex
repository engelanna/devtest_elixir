defmodule PrivateAPI.V1.Views.JSON.TargetGroupView do
  use PrivateAPI.V1.Views, :json_view

  def render("index.json", %{target_groups: target_groups}) do
    Enum.map(target_groups, &display/1)
  end

  def render("show.json", %{target_group: target_group}) do
    display(target_group)
  end


  defp display(target_group) do
    %{
      external_id: target_group.external_id,
      name: target_group.name
    }
  end
end
