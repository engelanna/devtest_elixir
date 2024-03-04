defmodule PrivateAPI.Plugs.VerifyToken do
  @moduledoc """
  In order to pass this verification, a request has to have its "authorization" header set to:
    bearer Application.get_env(:private_api, :api_token)
  """

  import Plug.Conn
  require Logger


  def init(opts), do: opts

  def call(conn, _opts) do
    ["Bearer " <> received_api_token] = get_req_header(conn, "authorization")

    if stored_api_token_matched(received_api_token) do
      conn
    else
      conn
      |> put_status(:unauthenticated)
      |> halt()
    end
  end

  defp stored_api_token_matched(received_api_token) do
    received_api_token == Application.get_env(:private_api, :api_token)
  end
end
