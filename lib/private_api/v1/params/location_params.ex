defmodule PrivateAPI.V1.Params.LocationParams do
  @moduledoc false

  use PrivateAPI.V1.Params, :params

  embedded_schema do
    field :id, Ecto.UUID
    field :panel_size, :integer
  end

  def validate(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(location_params, attrs) do
    location_params
    |> cast(attrs, [:id, :panel_size])
    |> validate_required([:id, :panel_size])
  end
end
