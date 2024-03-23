defmodule DevtestElixir.PricingStrategies.CountArraysOverNElementsAtUrl do
  @moduledoc false

  use HTTPoison.Base

  def call(
    url \\ "https://openlibrary.org/search.json?q=the+lord+of+the+rings",
    min_array_length \\ 10
  ) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- get(url),
         json_object <- Jason.decode!(body),
         price <- count_arrays(json_object, min_array_length)
    do
      price
    end
  end


  defp count_arrays(input, min_array_length) do
    input = convert_to_list_if_map(input)

    Enum.reduce(input, 0,
      fn input_element, count_so_far ->
        is_an_interesting_list = is_list(input_element) && length(input_element) >= min_array_length

        cond do
          is_an_interesting_list ->
            count_so_far + count_arrays(input_element, min_array_length) + 1

          is_list(input_element) || is_map(input_element) ->
            count_so_far + count_arrays(input_element, min_array_length)

          true -> count_so_far
        end
      end
    )
  end

  defp convert_to_list_if_map(potential_map) do
    if is_map(potential_map) do
      Map.values(potential_map)
    else
      potential_map
    end
  end
end
