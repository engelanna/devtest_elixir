defmodule PrivateAPI.Repo.Migrations.CreateLocationGroups do
  use Ecto.Migration

  def change do
    create table(:location_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string, [null: false]

      add :country_id, references(:countries, on_delete: :restrict, type: :binary_id)
      add :panel_provider_id, references(:panel_providers, on_delete: :restrict, type: :integer)

      timestamps(type: :utc_datetime)
    end

    create index(:location_groups, [:country_id])
    create index(:location_groups, [:panel_provider_id])
  end
end
