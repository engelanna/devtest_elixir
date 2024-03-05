defmodule PrivateAPI.Plugs.VerifyTokenTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Plug.Conn.Status, only: [code: 1]

  alias PrivateAPI.Plugs.VerifyToken

  setup do
    {:ok,
      conn: conn(:get, "/"),
      tokens: %{
        correct: Application.get_env(:devtest_elixir, PrivateAPI.Endpoint)[:api_token],
        wrong: "This token isn't going to cut it.",
        missing: nil
      }
    }
  end

  test "API token correct => connection not halted", %{conn: conn, tokens: %{correct: correct_token}} do
    conn_status_before_plug = conn.status

    conn = conn |> put_req_header("authorization", "bearer #{correct_token}")
                |> VerifyToken.call([])
    conn_status_after_plug = conn.status

    assert conn_status_before_plug == conn_status_after_plug
    refute conn.halted
  end

  test "wrong API token => connection halted", %{conn: conn, tokens: %{wrong: wrong_token}} do
    refute conn.status == :unauthorized

    conn = conn |> put_req_header("authorization", "bearer #{wrong_token}")
                |> VerifyToken.call([])

    assert conn.status == code(:unauthorized)
    assert conn.halted
  end

  test "API token missing => connection halted", %{conn: conn, tokens: %{missing: no_token}} do
    refute conn.status == :unauthorized

    conn = conn |> put_req_header("authorization", "bearer #{no_token}")
                |> VerifyToken.call([])

    assert conn.status == code(:unauthorized)
    assert conn.halted
  end
end
