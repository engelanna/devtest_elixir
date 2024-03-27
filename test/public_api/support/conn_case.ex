defmodule Test.PublicAPI.Support.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use Test.PublicAPI.Support.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  setup tags do
    Test.Support.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  import Plug.Conn

  setup %{conn: conn} do
    {:ok,
    conn: put_req_header(conn, "accept", "application/json")
       |> put_req_header(
          "authorization", "bearer " <> Application.get_env(
            :devtest_elixir, PublicAPI.Endpoint
          )[:api_token]
        )}
  end

  using do
    quote do
      # The default endpoint for testing
      @endpoint PublicAPI.Endpoint

      use PublicAPI, :verified_routes

      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import Test.PublicAPI.Support.ConnCase
    end
  end
end
