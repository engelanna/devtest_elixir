defmodule PublicAPI.V1.Views.ErrorJSONTest do
  use PublicAPI.ConnCase, async: true

  test "renders 404" do
    assert PublicAPI.V1.Views.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert PublicAPI.V1.Views.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
