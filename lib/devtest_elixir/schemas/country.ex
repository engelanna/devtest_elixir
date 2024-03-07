defmodule DevtestElixir.Schemas.Country do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "countries" do
    field :country_code, :string
    belongs_to :panel_provider, DevtestElixir.Schemas.PanelProvider

    # has_many :location_groups, DevtestElixir.Schemas.LocationGroup
    # many_to_many :target_groups, DevtestElixir.Schemas.TargetGroup, join_through: "countries_target_groups"

    timestamps(type: :utc_datetime)
  end

  def changeset(country, attrs) do
    country
    |> cast(attrs, [:country_code, :panel_provider_id])
    |> validate_required([:country_code])
  end
end
