defmodule DevtestElixir.Repo.Migrations.SeedCountries do
  use Ecto.Migration

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Contexts.UTCTimestampNoMicroseconds
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Country


  @doc """
  If no Countries present, creates the 3 predefined Countries.
  """
  def up do
    if Repo.aggregate(Country, :count) == 0 do
      Repo.insert_all(Country, seeds())
    end
  end

  @doc """
  Deletes the 3 predefined Countries if they are present.
  """
  def down do
    Enum.each(
      seeds(),
      fn seed ->
        Repo.delete_all(
          from(
            c in Country,
            where:
              c.id == ^seed.id and
              c.country_code == ^seed.country_code and
              c.panel_provider_id == ^seed.panel_provider_id
          )
        )
      end
    )
  end


  defp seeds() do
    timestamp = UTCTimestampNoMicroseconds.new()

    [
      %{
        id: "0ba7b810-9dad-11d1-80b4-00c04fd430c8",
        country_code: "AZ",
        panel_provider_id: 1,
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "550e8400-e29b-41d4-a716-446655440000",
        country_code: "EH",
        panel_provider_id: 2,
        inserted_at: timestamp,
        updated_at: timestamp        
      },
      %{
        id: "923e4567-e89b-12d3-a456-426614174002",
        country_code: "MU",
        panel_provider_id: 3,
        inserted_at: timestamp,
        updated_at: timestamp
      }
    ]
  end
end
