defmodule DevtestElixir.Repo.Migrations.CreateLocationsLocationGroups do
  use Ecto.Migration

  def change do
    create table(:locations_location_groups) do
      add :location_id, references(:locations, type: :binary_id, on_delete: :delete_all), null: false
      add :location_group_id, references(:location_groups, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:locations_location_groups, [:location_id, :location_group_id])
  end
end
