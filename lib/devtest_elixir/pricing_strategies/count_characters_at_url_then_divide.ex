defmodule DevtestElixir.PricingStrategies.CountCharactersAtUrlThenDivide do
  @moduledoc false

  use HTTPoison.Base

  def call(
    url \\ "https://time.com",
    desired_character \\ "a",
    divide_price_by \\ 100
  ) do
    with {:ok, %{status_code: 200, body: body}} <- get(url),
         character_count <- String.graphemes(body)
                            |> Enum.frequencies()
                            |> then(& &1[desired_character]),
        price <- character_count / divide_price_by
    do
      price
    end
  end
end
