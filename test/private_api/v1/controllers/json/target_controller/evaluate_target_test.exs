defmodule Test.PrivateAPI.V1.Controllers.JSON.TargetController.EvaluateTargetTest do
  use Test.PrivateAPI.Support.ConnCase, async: true
  use Mimic

  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.PanelProviderFactory

  describe "responding with Locations matching the Country's PanelProvider" do
    test "when locations/:country_code called with a valid :country_code", %{
      conn: conn,
      post_params: post_params,
      expected_response: expected_response
    } do
      conn = post(conn, ~p"/private_api/v1/evaluate_target", post_params)

      assert json_response(conn, 200) == expected_response
    end
  end

  setup do
    stub(DevtestElixir.PricingStrategies.CountCharactersAtUrlThenDivide, :call, fn -> 237 end)

    panel_provider = PanelProviderFactory.create(%{pricing_strategy_code: "count_characters_at_url_then_divide"})
    czech_republic = CountryFactory.create(%{country_code: "CZ", panel_provider_id: panel_provider.id})

    [
      post_params: %{
        country_code: czech_republic.country_code,
        target_group_id: Ecto.UUID.generate(),
        locations: [
          %{id: Ecto.UUID.generate(), panel_size: -1}
        ]
      },
      expected_response: %{"price" => 237}
    ]
  end
end
