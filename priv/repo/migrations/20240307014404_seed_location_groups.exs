defmodule DevtestElixir.Repo.Migrations.SeedLocationGroups do
  use Ecto.Migration

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Contexts.UTCTimestampNoMicroseconds
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.LocationGroup


  @doc """
  If no LocationGroups present, creates the 4 predefined LocationGroups.
  """
  def up do
    if Repo.aggregate(LocationGroup, :count) == 0 do
      Repo.insert_all(LocationGroup, seeds())
    end
  end

  @doc """
  Deletes the 4 predefined LocationGroups if they are present.
  """
  def down do
    Enum.each(
      seeds(),
      fn seed ->
        Repo.delete_all(
          from(
            lg in LocationGroup,
            where:
              lg.id == ^seed.id and
              lg.name == ^seed.name and
              lg.country_id == ^seed.country_id and
              lg.panel_provider_id == ^seed.panel_provider_id
          )
        )
      end
    )
  end


  defp seeds do
    timestamp = UTCTimestampNoMicroseconds.new()

    [
      %{
        id: "a3846db6-f701-4ab6-a06e-722d520dd8bd",
        name: "An example location group",
        country_id: "0ba7b810-9dad-11d1-80b4-00c04fd430c8",
        panel_provider_id: 1,
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "d79269de-b578-4500-9298-bb0a925cbd67",
        name: "A different location group",
        country_id: "550e8400-e29b-41d4-a716-446655440000",
        panel_provider_id: 2,
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "5cb90b63-7a28-408f-bfe0-bd13d8516703",
        name: "Yet another location group",
        country_id: "923e4567-e89b-12d3-a456-426614174002",
        panel_provider_id: 3,
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "d418f6fc-0765-4154-b251-2b4f2f63db49",
        name: "Still another location group",
        country_id: "923e4567-e89b-12d3-a456-426614174002",
        panel_provider_id: 1,
        inserted_at: timestamp,
        updated_at: timestamp
      }
    ]
  end
end
