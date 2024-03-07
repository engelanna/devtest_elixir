defmodule DevtestElixir.Contexts.LocationContext do
  @moduledoc false

  import Ecto.Changeset, only: [get_field: 2, put_change: 3]

  @hashing_secrets_config %{
    algorithm: :sha256,
    font_case: :lower
  }

  def put_secret_code_hash(changeset) do
   case get_field(changeset, :secret_code) do
      nil -> changeset
      secret_code ->
        salt = generate_salt()

        changeset
        |> put_change(:secret_code_salt, salt)
        |> put_change(:secret_code_hash, hash_secret_code(secret_code, salt))
   end
 end


  defp generate_salt do
    :crypto.strong_rand_bytes(16) |> Base.encode64()
  end

  defp hash_secret_code(secret_code, salt) do
    :crypto.hash(@hashing_secrets_config[:algorithm], secret_code <> salt)
    |> Base.encode16(case: @hashing_secrets_config[:font_case])
  end
end
