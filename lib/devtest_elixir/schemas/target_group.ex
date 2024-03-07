defmodule DevtestElixir.Schemas.TargetGroup do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset
  import DevtestElixir.Contexts.SecretCodeContext

  alias DevtestElixir.Schemas.Country

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

  @doc false
  def changeset(target_group, attrs) do
    target_group
    |> cast(attrs, [:external_id, :parent_id, :name, :secret_code])
    |> put_secret_code_hash_and_salt()
    |> validate_required([:external_id, :name, :secret_code_hash, :secret_code_salt])
  end
end
