defmodule DevtestElixir.PricingStrategies do
  @moduledoc false


  def pricing_strategy_module(snake_case_pricing_strategy_code) do
    with camelized <- Macro.camelize(snake_case_pricing_strategy_code) do
      "Elixir.DevtestElixir.PricingStrategies.#{camelized}"
      |> String.to_existing_atom()
    end
  end
end
