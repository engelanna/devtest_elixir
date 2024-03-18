defmodule DevtestElixir.Schemas.Country do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

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
    Repo.preload(country, :target_groups)
    |> cast(attrs, [:country_code, :panel_provider_id])
    |> validate_required([:country_code])
    |> upcase_country_code()
    |> unique_constraint(:country_code)
    |> cast_assoc(:target_groups, with: &TargetGroup.changeset/2)
  end


  defp upcase_country_code(changeset), do: update_change(changeset, :username, &String.upcase/1)
end
