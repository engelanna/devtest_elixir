defmodule Test.DevtestElixir.PricingStrategies.CountArraysOverNElementsAtJsonUrlTest do
  use Test.Support.CassetteCase, async: true

  alias DevtestElixir.PricingStrategies.CountArraysOverNElementsAtJsonUrl

  describe "calculating panel price by counting arrays > n elements at URL" do
    test "when scraping openlibrary.org" do
      use_cassette "openlibrary_org_27032024" do

        expected_price = 237
        actual_price = CountArraysOverNElementsAtJsonUrl.call()

        assert expected_price == actual_price
      end
    end
  end
end
