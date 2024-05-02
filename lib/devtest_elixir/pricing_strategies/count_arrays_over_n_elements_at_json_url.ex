defmodule DevtestElixir.PricingStrategies.CountArraysOverNElementsAtJsonUrl do
  @moduledoc false

  use HTTPoison.Base

  def call(
    url \\ "https://openlibrary.org/search.json?q=the+lord+of+the+rings",
    min_array_length \\ 10
  ) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- get(url),
         json_object <- Jason.decode!(body)
    do
      _price = json_array_count(json_object, min_array_length)
    end
  end


  defp json_array_count(input_json, min_array_length) when is_list(input_json) do
    Enum.reduce(input_json, 0, fn input_list_element, count_so_far ->
        cond do
          an_interesting_list?(input_list_element, min_array_length) ->
            count_so_far + json_array_count(input_list_element, min_array_length) + 1

          is_list(input_list_element) || is_map(input_list_element) ->
            count_so_far + json_array_count(input_list_element, min_array_length)

          true -> count_so_far
        end
      end
    )
  end

  defp json_array_count(input_json, min_array_length) when is_map(input_json) do
    json_array_count(
      Map.values(input_json),
      min_array_length
    )
  end

  defp an_interesting_list?(potential_list, min_interesting_length) do
    is_list(potential_list) && length(potential_list) >= min_interesting_length
  end
end
