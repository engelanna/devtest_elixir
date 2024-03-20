defmodule Test.PrivateAPI.V1.Controllers.JSON.TargetGroupController.TargetGroupsForCountryCodeTest do
  use Test.PrivateAPI.Support.ConnCase, async: true

  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.PanelProviderFactory
  alias Test.Support.Factories.TargetGroupFactory

  describe "responding with TargetGroups matching the Country's PanelProvider" do
    test "when target_groups/:country_code called with a valid :country_code", %{
      conn: conn,
      country_code: country_code,
      expected_response: expected_response
    } do

      conn = get(conn, ~p"/private_api/v1/target_groups/#{country_code}")

      assert json_response(conn, 200) == expected_response
    end
  end

  setup do
    desired_panel_provider = PanelProviderFactory.create()
    undesired_panel_provider = PanelProviderFactory.create()

    netherlands = CountryFactory.create(%{country_code: "NL", panel_provider_id: desired_panel_provider.id})
    germany = CountryFactory.create(%{country_code: "DE", panel_provider_id: undesired_panel_provider.id})

    dutch_protestants = TargetGroupFactory.create(%{name: "Must be returned (Country and PanelProvider both match)",
      countries: [netherlands], panel_provider_id: desired_panel_provider.id})
    _dutch_catholics = TargetGroupFactory.create(%{name: "Mustn't be returned (wrong PanelProvider)",
      countries: [netherlands], panel_provider_id: undesired_panel_provider.id})
    _german_protestants = TargetGroupFactory.create(%{name: "Mustn't be returned (wrong Country)",
      countries: [germany], panel_provider_id: desired_panel_provider.id})

    [
      country_code: netherlands.country_code,
      expected_response: [%{
        "external_id" => dutch_protestants.external_id,
        "name" => dutch_protestants.name
      }]
    ]
  end
end
