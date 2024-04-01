defmodule Test.PublicAPI.V1.Controllers.JSON.LocationController.LocationsForCountryCodeTest do
  use Test.PublicAPI.Support.ConnCase, async: true

  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.LocationFactory
  alias Test.Support.Factories.LocationGroupFactory
  alias Test.Support.Factories.PanelProviderFactory

  describe "responding with Locations matching the Country's PanelProvider" do
    test "when locations/:country_code called with a valid :country_code", %{
      conn: conn,
      country_code: country_code,
      expected_response: expected_response
    } do

      conn = get(conn, ~p"/public_api/v1/locations/#{country_code}")

      assert json_response(conn, 200) == expected_response
    end
  end

  setup do
    desired_panel_provider = PanelProviderFactory.create()
    undesired_panel_provider = PanelProviderFactory.create()

    poland = CountryFactory.create(%{country_code: "PL", panel_provider_id: desired_panel_provider.id})
    germany = CountryFactory.create(%{country_code: "DE", panel_provider_id: undesired_panel_provider.id})

    location_1_in_poland = LocationFactory.create(%{name: "Poznan"})
    location_2_in_poland = LocationFactory.create(%{name: "Gdansk"})
    location_3_in_germany = LocationFactory.create(%{name: "Frankfurt"})

    polish_locations_with_desired_panel_provider = LocationGroupFactory.create(%{
      country_id: poland.id,
      locations: [location_1_in_poland],
      name: "In Poland & having the desired panel provider (we need to match these locations)",
      panel_provider_id: desired_panel_provider.id
    }).locations

    LocationGroupFactory.create(%{
      country_id: poland.id,
      locations: [location_2_in_poland],
      name: "In Poland, but an undesired panel provider (we should NOT match these locations)",
      panel_provider_id: undesired_panel_provider.id
    })

    LocationGroupFactory.create(%{
      country_id: germany.id,
      locations: [location_3_in_germany],
      name: "In Germany (we should NOT match these locations), but having the desired panel provider",
      panel_provider_id: desired_panel_provider.id
    })

    [
      country_code: poland.country_code,
      expected_response: [%{
        "external_id" => List.first(polish_locations_with_desired_panel_provider).external_id,
        "name" => List.first(polish_locations_with_desired_panel_provider).name
      }]
    ]
  end
end
