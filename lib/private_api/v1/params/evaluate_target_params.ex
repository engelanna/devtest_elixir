defmodule PrivateAPI.V1.Params.EvaluateTargetParams do
  @moduledoc false

  use PrivateAPI.V1.Params, :params

  alias PrivateAPI.V1.Params.LocationParams

  embedded_schema do
    field :country_code, :string
    field :target_group_id, Ecto.UUID

    embeds_many(:locations, LocationParams)
  end

  def validate(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(evaluate_target_params, attrs) do
    evaluate_target_params
    |> cast(attrs, [:country_code, :target_group_id])
    |> validate_length(:country_code, is: 2)
    |> validate_required([:country_code, :target_group_id])
    |> cast_embed(:locations, required: true)
  end
end
