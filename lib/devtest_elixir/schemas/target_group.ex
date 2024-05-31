defmodule DevtestElixir.Schemas.TargetGroup do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias DevtestElixir.Mixins.SecretCodeMixin
  alias DevtestElixir.Schemas.Country
  alias DevtestElixir.Schemas.PanelProvider

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "target_groups" do
    field :external_id, Ecto.UUID, autogenerate: true
    field :parent_id, Ecto.UUID
    field :name, :string

    field :secret_code, :string, [virtual: true]
    field :secret_code_hash, :string
    field :secret_code_salt, :string

    belongs_to :panel_provider, PanelProvider

    many_to_many :countries, Country, join_through: "countries_target_groups"

    timestamps(type: :utc_datetime)
  end

  def changeset(target_group, attrs) do
    cast(target_group, attrs, [:external_id, :parent_id, :name, :secret_code, :panel_provider_id])
    |> SecretCodeMixin.put_secret_code_hash_and_salt()
    |> validate_required([:external_id, :name, :secret_code_hash, :secret_code_salt])
    |> cast_assoc(:countries, with: &Country.changeset/2)
    |> validate_being_root_for_country_association(attrs)
  end


  defp validate_being_root_for_country_association(changeset, attrs) do
    are_countries_involved? = Map.get(attrs, :countries) != nil
    is_parent_id_present? = get_field(changeset, :parent_id)

    validation_passed = !(are_countries_involved? && is_parent_id_present?)

    case validation_passed do
      false -> add_error(changeset, :parent_id,
        "Only root TargetGroups (those without .parent_id) may be associated with Countries")
      true -> changeset
    end
  end
end
