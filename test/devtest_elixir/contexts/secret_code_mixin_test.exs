defmodule Test.DevtestElixir.Mixins.SecretCodeMixinTest do
  use Test.Support.DataCase, async: true

  alias DevtestElixir.Mixins.SecretCodeMixin
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Location

  setup do
    [location: create_location()]
  end

  test "computing the hash (from secret_code + salt) in a reproducible way", %{location: location} do
    expected_hash = location.secret_code_hash
    actual_hash = SecretCodeMixin.hash_secret_code_with_salt(
      predefined_secret_code(),
      location.secret_code_salt
    )

    assert actual_hash == expected_hash
  end


  defp create_location do
    %Location{}
    |> Location.changeset(
      %{
        name: "Test Location",
        external_id: Ecto.UUID.generate(),
        secret_code: predefined_secret_code()
      })
    |> Repo.insert!()
  end

  defp predefined_secret_code, do: "3nDFoMn31FRnc/Mo"
end
