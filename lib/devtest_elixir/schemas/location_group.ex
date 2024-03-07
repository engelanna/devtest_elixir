defmodule DevtestElixir.Schemas.LocationGroup do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "location_groups" do
    field :name, :string

    field :country_id, :binary_id
    field :panel_provider_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(location_group, attrs) do
    location_group
    |> cast(attrs, [:name, :country_id, :panel_provider_id])
    |> validate_required([:name, :country_id, :panel_provider_id])
  end
end
