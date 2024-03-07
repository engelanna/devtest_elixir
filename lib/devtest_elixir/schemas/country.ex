defmodule DevtestElixir.Schemas.Country do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias DevtestElixir.Contexts.TargetGroupContext
  alias DevtestElixir.Schemas.LocationGroup
  alias DevtestElixir.Schemas.PanelProvider
  alias DevtestElixir.Schemas.TargetGroup


  @primary_key {:id, :binary_id, autogenerate: true}
  schema "countries" do
    field :country_code, :string
    belongs_to :panel_provider, PanelProvider

    has_many :location_groups, LocationGroup
    many_to_many :target_groups, TargetGroup, join_through: "countries_target_groups"

    timestamps(type: :utc_datetime)
  end

  def changeset(country, attrs) do
    country
    |> cast(attrs, [:country_code, :panel_provider_id])
    |> validate_required([:country_code])
    |> validate_target_group_is_root()
 end


 defp validate_target_group_is_root(changeset) do
    validate_change(changeset, :target_group_id, fn :target_group_id, target_group_id ->
      if TargetGroupContext.root?(target_group_id) do
        []
      else
        [{:target_group_id, "must be a root node"}]
      end
    end)
  end
end
