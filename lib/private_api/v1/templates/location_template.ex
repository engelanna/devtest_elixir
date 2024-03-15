defmodule PrivateAPI.V1.Templates.LocationTemplate do
  @moduledoc false

  alias DevtestElixir.Schemas.Location

  def index(%{locations: locations}) do
    %{data: for(location <- locations, do: data(location))}
  end

  def show(%{location: location}) do
    %{data: data(location)}
  end

  defp data(%Location{} = location) do
    %{
      id: location.id,
      location_code: location.location_code,
      inserted_at: location.inserted_at,
      updated_at: location.updated_at
    }
  end
end
