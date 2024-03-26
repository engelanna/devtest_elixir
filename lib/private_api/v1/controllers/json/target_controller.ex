defmodule PrivateAPI.V1.Controllers.JSON.TargetController do
  @moduledoc false

  use PrivateAPI.V1.Controllers, :json_controller

  alias DevtestElixir.Contexts.PanelProviderContext
  alias PrivateAPI.V1.Params.EvaluateTargetParams

  def evaluate_target(conn, params) do
    with %{valid?: true, changes: %{country_code: country_code}} <- EvaluateTargetParams.validate(params),
      price <- PanelProviderContext.price_from_country_code(country_code)
    do
      render(conn, :show, %{target: %{price: price}})
    end
  end
end
