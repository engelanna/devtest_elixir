defmodule DevtestElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PrivateAPI.Telemetry,
      PublicAPI.Telemetry,
      DevtestElixir.Repo,
      {DNSCluster, query: Application.get_env(:devtest_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DevtestElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DevtestElixir.Finch},
      # Start a worker by calling: DevtestElixir.Worker.start_link(arg)
      # {DevtestElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      PrivateAPI.Endpoint,
      PublicAPI.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DevtestElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PrivateAPI.Endpoint.config_change(changed, removed)
    PublicAPI.Endpoint.config_change(changed, removed)
    :ok
  end
end
