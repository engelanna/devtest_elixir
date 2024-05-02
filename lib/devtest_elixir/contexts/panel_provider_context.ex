defmodule DevtestElixir.Contexts.PanelProviderContext do
  @moduledoc false

  alias DevtestElixir.Contexts.CountryContext
  alias DevtestElixir.Schemas.PanelProvider

  def random_pricing_strategy_code do
    Enum.random(PanelProvider.allowed_pricing_strategy_codes)
  end

  def price_from_country_code(country_code) do
    with country <- CountryContext.from_country_code_with_panel_provider(country_code),
         panel_provider <- country.panel_provider,
         pricing_strategy_code <- panel_provider.pricing_strategy_code,
         pricing_module_name <- DevtestElixir.PricingStrategies.which_module_should_we_run?(pricing_strategy_code)
    do
      pricing_module_name.call()
    end
  end
end
