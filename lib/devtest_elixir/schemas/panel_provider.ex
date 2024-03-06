defmodule DevtestElixir.Schemas.PanelProvider do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "panel_providers" do
    field :pricing_strategy_code, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(panel_provider, attrs) do
    panel_provider
    |> cast(attrs, [:pricing_strategy_code])
    |> validate_required([:pricing_strategy_code])
  end
end
