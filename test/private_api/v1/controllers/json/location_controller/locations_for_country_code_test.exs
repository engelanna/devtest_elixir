defmodule Test.PrivateAPI.V1.Controllers.JSON.LocationController.LocationsForCountryCodeTest do
  # TODO: Rename this controller test
  use Test.PrivateAPI.Support.ConnCase, async: true

  alias Test.Support.Factories.CountryFactory
  alias Test.Support.Factories.LocationFactory
  alias Test.Support.Factories.LocationGroupFactory
  alias Test.Support.Factories.PanelProviderFactory

  require Jason

  describe "locations/:country_code" do
    test "responding to a country code with locations matching the country's panel provider", %{
      conn: conn,
      country_code: country_code,
      expected_response: expected_response
    } do

      conn = get(conn, ~p"/private_api/v1/locations/#{country_code}")

      assert json_response(conn, 200) == expected_response
    end
  end

  setup do
    desired_panel_provider = Map.from_struct(PanelProviderFactory.create())
    undesired_panel_provider = Map.from_struct(PanelProviderFactory.create())

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
    }).locations

    LocationGroupFactory.create(%{
      country_id: germany.id,
      locations: [location_3_in_germany],
      name: "In Germany (we should NOT match these locations), but having the desired panel provider",
      panel_provider_id: desired_panel_provider.id
    }).locations

    [
      country_code: poland.country_code,
      expected_response: [%{
        "external_id" => List.first(polish_locations_with_desired_panel_provider).external_id,
        "name" => List.first(polish_locations_with_desired_panel_provider).name
      }]
    ]
  end
end
