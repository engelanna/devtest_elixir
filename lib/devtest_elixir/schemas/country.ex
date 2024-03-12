defmodule DevtestElixir.Schemas.Country do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

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
    |> cast_assoc(:target_groups, with: &TargetGroup.country_association_changeset/2)
  end
end
