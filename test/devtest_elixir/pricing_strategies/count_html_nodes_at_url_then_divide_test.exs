defmodule Test.DevtestElixir.PricingStrategies.CountHtmlNodesAtUrlThenDivideTest do
  use Test.Support.CassetteCase, async: true

  alias DevtestElixir.PricingStrategies.CountHtmlNodesAtUrlThenDivide

  describe "calculating panel price by counting HTML nodes at URL" do
    test "when scraping time.com" do
      use_cassette "time_com_27032024" do

        expected_price = 17.45
        actual_price = CountHtmlNodesAtUrlThenDivide.call()

        assert expected_price == actual_price
      end
    end
  end
end
