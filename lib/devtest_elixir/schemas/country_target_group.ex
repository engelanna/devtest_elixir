defmodule DevtestElixir.Schemas.CountryTargetGroup do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias DevtestElixir.Contexts.TargetGroupContext

  schema "countries_target_groups" do
    belongs_to :country, DevtestElixir.Schemas.Country, type: :binary_id
    belongs_to :target_group, DevtestElixir.Schemas.TargetGroup, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  def changeset(country_target_group, attrs) do
    country_target_group
    |> cast(attrs, [:country_id, :target_group_id])
    |> validate_required([:country_id, :target_group_id])
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
