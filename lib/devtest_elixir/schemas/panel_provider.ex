defmodule DevtestElixir.Schemas.PanelProvider do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "panel_providers" do
    field :pricing_strategy_code, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(panel_provider, attrs) do
    panel_provider
    |> cast(attrs, [:pricing_strategy_code])
    |> validate_required([:pricing_strategy_code])
    |> validate_pricing_strategy_code_allowed(attrs)
  end

  def allowed_pricing_strategy_codes do
    ~w/
      count_characters_at_url_then_divide
      count_arrays_over_n_elements_at_url
      count_html_nodes_at_url_then_divide
    /
  end


  defp validate_pricing_strategy_code_allowed(changeset, attrs) do
    validation_passed = Map.get(attrs, :pricing_strategy_code) in allowed_pricing_strategy_codes()

    if validation_passed do
      changeset
    else
      add_error(changeset, :pricing_strategy_code, "Unknown pricing strategy code")
    end
  end
end
