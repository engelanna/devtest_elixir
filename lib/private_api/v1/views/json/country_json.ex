defmodule PrivateAPI.Views.JSON.CountryJSON do

  alias DevtestElixir.Schemas.Country
  # alias PrivateAPI.V1.Controllers.CountryController

  @doc """
  Renders a list of countries.
  """
  def index(%{countries: countries}) do
    %{data: for(country <- countries, do: data(country))}
  end

  @doc """
  Renders a single country.
  """
  def show(%{country: country}) do
    %{data: data(country)}
  end

  defp data(%Country{} = country) do
    %{
      id: country.id,
      country_code: country.country_code,
      inserted_at: country.inserted_at,
      updated_at: country.updated_at
    }
  end
end
