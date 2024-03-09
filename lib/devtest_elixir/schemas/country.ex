defmodule DevtestElixir.Schemas.Country do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias DevtestElixir.Repo
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
    |> validate_each_target_group_is_root()
  end


  defp validate_each_target_group_is_root(changeset) do
    validate_change(changeset, :target_groups, fn :target_groups, target_groups ->
      roots = Repo.all(
        from tg in TargetGroup,
        where: tg.id in ^target_groups and is_nil(tg.parent_id)
      )

      if length(target_groups) == length(roots) do
        []
      else
        [{:target_groups, "All target groups must be root nodes (i.e. none of them may have a .parent_id"}]
      end
    end)
  end
end
