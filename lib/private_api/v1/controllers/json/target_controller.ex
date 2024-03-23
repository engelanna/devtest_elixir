defmodule PrivateAPI.V1.Controllers.JSON.TargetController do
  @moduledoc false

  use PrivateAPI.V1.Controllers, :json_controller

  alias DevtestElixir.Contexts.PanelProviderContext

  def evaluate_target(conn, %{
    "country_code" => country_code,
    "locations" => _locations,
    "target_group_id" => _target_group_id
  }) do
      with price <- PanelProviderContext.price_from_country_code(country_code) do
        render(conn, :show, %{
          target: %{price: price}
        })
    end
  end


  # TODO: Rework according to https://kubasub.proseful.com/params-modules-for-phoenix
  defp location_params(locations, permitted_params \\ %{
    id: &is_integer/1,
    panel_size: &is_integer/1
  }) do

    locations_with_illegal_keys_removed = locations |> Enum.map(&Map.take(&1, Map.keys(permitted_params)))

    _locations_that_passed_datatype_validators = Enum.filter(
      locations_with_illegal_keys_removed,
      fn location -> Enum.all?(
        permitted_params, fn {key, validator} -> apply(validator, [Map.get(location, key)]) end
      )
      end
    )
  end
end
