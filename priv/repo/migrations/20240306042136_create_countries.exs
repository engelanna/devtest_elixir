defmodule DevtestElixir.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries, primary_key: false) do
      add :id, :binary_id, [primary_key: true]
      add :country_code, :string, [null: false, unique: true]
      add :panel_provider_id, references(:panel_providers, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:countries, :panel_provider_id)
  end
end
