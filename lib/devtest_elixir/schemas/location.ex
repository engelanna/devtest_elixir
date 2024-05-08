defmodule DevtestElixir.Schemas.Location do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset
  import DevtestElixir.Mixins.SecretCodeMixin

  alias DevtestElixir.Schemas.LocationGroup

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "locations" do
    field :external_id, Ecto.UUID, autogenerate: true
    field :name, :string

    field :secret_code, :string, [virtual: true]
    field :secret_code_hash, :string
    field :secret_code_salt, :string

    many_to_many :location_groups, LocationGroup, join_through: "locations_location_groups"

    timestamps(type: :utc_datetime)
  end

  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :secret_code])
    |> put_secret_code_hash_and_salt()
    |> validate_required([:name, :secret_code_hash, :secret_code_salt])
  end
end
