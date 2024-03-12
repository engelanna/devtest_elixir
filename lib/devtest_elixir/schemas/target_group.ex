defmodule DevtestElixir.Schemas.TargetGroup do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset
  
  alias DevtestElixir.Contexts.Shared.SecretCodeContext
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
    target_group
    |> cast(attrs, [:external_id, :parent_id, :name, :secret_code])
    |> SecretCodeContext.put_secret_code_hash_and_salt()
    |> validate_required([:external_id, :name, :secret_code_hash, :secret_code_salt])
    |> cast_assoc(:countries, with: &Country.changeset/2)
  end

  def country_association_changeset(target_group, attrs) do
    changeset(target_group, attrs)
    |> validate_being_root_for_country_association
  end

  defp validate_being_root_for_country_association(changeset) do
    if get_field(changeset, :parent_id) do
      add_error(changeset, :parent_id,
        "Only root TargetGroups (those without .parent_id) may be associated with Countries")
    else
      changeset
    end
  end
end
