defmodule DevtestElixir.Repo.Migrations.CreatePanelProviders do
  use Ecto.Migration

  def up do
    create table(:panel_providers) do
      add :pricing_strategy_code, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end

  def down do
    drop table(:panel_providers)
  end
end
