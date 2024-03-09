defmodule DevtestElixir.Repo.Migrations.CreateTargetGroups do
  use Ecto.Migration

  def change do
    create table(:target_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :uuid
      add :parent_id, :uuid

      add :name, :string, [null: false]

      add :secret_code_hash, :string, [null: false]
      add :secret_code_salt, :string, [null: false]

      add :panel_provider_id, references(:panel_providers, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:target_groups, [:panel_provider_id])
  end
end
