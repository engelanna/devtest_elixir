defmodule PrivateAPI.V1.Views.JSON.TargetView do
  use PrivateAPI.V1.Views, :json_view

  def render("show.json", %{target: target}) do
    display(target)
  end


  defp display(target) do
    %{
      price: target.price
    }
  end
end
