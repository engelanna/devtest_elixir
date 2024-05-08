defmodule DevtestElixir.PricingStrategies do
  @moduledoc false


  @doc """
  snake_cased_pricing_strategy_code =>
    :"Elixir.DevtestElixir.PricingStrategies.SnakeCasedPricingStrategyCode"
  """
  def which_module_should_we_run?(snake_cased_pricing_strategy_code) do
    with camelized <- Macro.camelize(snake_cased_pricing_strategy_code) do
      "Elixir.DevtestElixir.PricingStrategies.#{camelized}"
      |> String.to_existing_atom()
    end
  end
end
