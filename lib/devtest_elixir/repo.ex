defmodule DevtestElixir.Repo do
  use Ecto.Repo,
    otp_app: :devtest_elixir,
    adapter: Ecto.Adapters.Postgres
end
