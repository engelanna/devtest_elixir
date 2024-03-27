defmodule Test.PublicAPI.V1.Plugs.VerifyTokenTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Plug.Conn.Status, only: [code: 1]

  alias PublicAPI.V1.Plugs.VerifyToken

  setup do
    {:ok,
      conn: conn(:get, "/"),
      tokens: %{
        correct: Application.get_env(:devtest_elixir, PrivateAPI.Endpoint)[:api_token],
        missing: nil,
        wrong: "This token isn't going to cut it."
      }
    }
  end

  describe "establishing the connection" do
    test "when API token correct", %{conn: conn, tokens: %{correct: correct_token}} do
      conn_status_before_plug = conn.status

      conn = conn |> put_req_header("authorization", "bearer #{correct_token}")
                  |> VerifyToken.call([])
      conn_status_after_plug = conn.status

      assert conn_status_before_plug == conn_status_after_plug
      refute conn.halted
    end
  end

  describe "halting the connection" do
    test "when API token missing", %{conn: conn, tokens: %{missing: no_token}} do
      refute conn.status == :unauthorized

      conn = conn |> put_req_header("authorization", "bearer #{no_token}")
                  |> VerifyToken.call([])

      assert conn.status == code(:unauthorized)
      assert conn.halted
    end

    test "when API token wrong", %{conn: conn, tokens: %{wrong: wrong_token}} do
      refute conn.status == :unauthorized

      conn = conn |> put_req_header("authorization", "bearer #{wrong_token}")
                  |> VerifyToken.call([])

      assert conn.status == code(:unauthorized)
      assert conn.halted
    end
  end
end
