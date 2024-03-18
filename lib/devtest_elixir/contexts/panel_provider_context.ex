defmodule DevtestElixir.Contexts.PanelProviderContext do
  @moduledoc false

  alias DevtestElixir.Schemas.PanelProvider

  def random_pricing_strategy_code do
    Enum.random(PanelProvider.allowed_pricing_strategy_codes)
  end
end
