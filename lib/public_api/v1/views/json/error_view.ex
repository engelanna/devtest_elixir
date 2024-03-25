defmodule PublicAPI.V1.Views.JSON.ErrorView do
  use PublicAPI.V1.Views, :json_view

  def render("400.json", _assigns) do
    %{error: "Bad Request"}
  end

  def render("404.json", _assigns) do
    %{error: "Not Found"}
  end

  def render("500.json", _assigns) do
    %{error: "Internal Server Error"}
  end
end
