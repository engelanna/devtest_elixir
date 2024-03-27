defmodule DevtestElixir.PricingStrategies.CountHtmlNodesAtUrlThenDivide do
  @moduledoc false

  use HTTPoison.Base

  def call(
    url \\ "https://time.com",
    divide_price_by \\ 100
  ) do

    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- get(url) do
     _price = count_html_nodes(body) / divide_price_by
    end
  end


  defp count_html_nodes(html) do
    html
    |> Floki.find("*")
    |> length()
  end
end
