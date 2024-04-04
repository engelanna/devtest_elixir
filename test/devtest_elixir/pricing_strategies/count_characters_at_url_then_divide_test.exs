defmodule Test.DevtestElixir.PricingStrategies.CountCharactersAtUrlThenDivideTest do
  use Test.Support.CassetteCase, async: true

  alias DevtestElixir.PricingStrategies.CountCharactersAtUrlThenDivide

  describe "calculating panel price by counting characters at URL" do
    test "when scraping time.com" do
      use_cassette "time_com_27032024" do

        expected_price = 103.19
        actual_price = CountCharactersAtUrlThenDivide.call()

        assert expected_price == actual_price
      end
    end
  end
end
