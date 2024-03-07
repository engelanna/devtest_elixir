defmodule DevtestElixir.Contexts.SecretCodeContext do
  @moduledoc """
  Prevent storing plain-text secrets in your database. Store a hash and a salt instead.

  Currently works with the following fields, which must be present in your Schema:
    field :secret_code, :string, [virtual: true]
    field :secret_code_hash, :string
    field :secret_code_salt, :string

  Use from the Schema like this:
    def changeset(your_schema, attrs) do
      your_schema
      |> cast(attrs, [:unrelated_attribute, :secret_code])
      |> put_secret_code_hash()
      |> validate_required([:unrelated_attribute, :secret_code_hash, :secret_code_salt])
    end
  """

  import Ecto.Changeset, only: [get_field: 2, put_change: 3]

  @hashing_secrets_config %{
    algorithm: :sha256,
    font_case: :lower,
    salt_length: 16
  }


  def hash_secret_code_with_salt(secret_code, salt) do
    :crypto.hash(@hashing_secrets_config[:algorithm], secret_code <> salt)
    |> Base.encode16(case: @hashing_secrets_config[:font_case])
  end

  def put_secret_code_hash_and_salt(changeset) do
    case get_field(changeset, :secret_code) do
      nil -> changeset
      secret_code ->
        salt = generate_salt()

        changeset
        |> put_change(:secret_code_salt, salt)
        |> put_change(:secret_code_hash, hash_secret_code_with_salt(secret_code, salt))
    end
  end


  defp generate_salt do
    :crypto.strong_rand_bytes(@hashing_secrets_config.salt_length) |> Base.encode64()
  end
end
