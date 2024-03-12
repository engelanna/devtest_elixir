defmodule DevtestElixir.Repo.Migrations.CreateCountriesTargetGroups do
  use Ecto.Migration

  def change do
    create table(:countries_target_groups, primary_key: false) do
      add :country_id, references(:countries, type: :binary_id, on_delete: :delete_all), null: false
      add :target_group_id, references(:target_groups, type: :binary_id, on_delete: :delete_all), null: false
    end

    create unique_index(:countries_target_groups, [:country_id, :target_group_id])
  end
end
