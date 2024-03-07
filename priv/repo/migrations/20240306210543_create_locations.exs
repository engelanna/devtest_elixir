defmodule DevtestElixir.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :binary_id, [primary_key: true]
      add :external_id, :uuid, [null: false]

      add :name, :string, [null: false]

      add :secret_code_hash, :string, [null: false]
      add :secret_code_salt, :string, [null: false]

      timestamps(type: :utc_datetime)
    end
  end
end
