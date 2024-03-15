defmodule Test.PrivateAPI.V1.Controllers.LocationControllerTest do
  use Test.PrivateAPI.Support.ConnCase

  alias DevtestElixir.Schemas.Location
  alias PrivateAPI.V1.Controllers.LocationController
  alias Test.Support.Factories.CountryFactory

  setup do
    existing_country_code = CountryFactory.create(%{country_code: "PL"}).country_code

    [
      absent_country_code: "XX",
      existing_country_code: existing_country_code,
      illegal_country_code: "Not 2 characters long"
    ]
  end

  # describe "locations/:country_code" do
    # It should return locations which belong to the selected country based on it's current panel provider


      test "establishing connection when API token correct", %{conn: conn, tokens: %{correct: correct_token}} do
        assert false
      end
  #   test "lists all countries", %{conn: conn} do
  #     conn = get(conn, ~p"/private_api/v1/locations/:country_code")
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create location" do
  #   test "renders location when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/countries", location: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, ~p"/api/countries/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "location_code" => "some location_code",
  #              "inserted_at" => "2024-03-13T14:27:00Z",
  #              "updated_at" => "2024-03-13T14:27:00Z"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/countries", location: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update location" do
  #   setup [:create_location]

  #   test "renders location when data is valid", %{conn: conn, location: %Location{id: id} = location} do
  #     conn = put(conn, ~p"/api/countries/#{location}", location: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, ~p"/api/countries/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "location_code" => "some updated location_code",
  #              "inserted_at" => "2024-03-14T14:27:00Z",
  #              "updated_at" => "2024-03-14T14:27:00Z"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, location: location} do
  #     conn = put(conn, ~p"/api/countries/#{location}", location: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete location" do
  #   setup [:create_location]

  #   test "deletes chosen location", %{conn: conn, location: location} do
  #     conn = delete(conn, ~p"/api/countries/#{location}")
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, ~p"/api/countries/#{location}")
  #     end
  #   end
  # end

  # defp create_location(_) do
  #   location = location_fixture()
  #   %{location: location}
  # end
end
