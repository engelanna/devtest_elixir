defmodule Test.Support.Factories.PanelProviderFactory do
  @moduledoc false

  alias DevtestElixir.Repo
  alias DevtestElixir.Contexts.PanelProviderContext
  alias DevtestElixir.Schemas.PanelProvider

  def create(opts \\ %{}) do
    changeset(opts)
    |> Repo.insert()
    |> elem(1)
  end

  def changeset(opts \\ %{}) do
    %PanelProvider{}
    |> PanelProvider.changeset(
      Map.merge(
        %{pricing_strategy_code: PanelProviderContext.random_pricing_strategy_code()},
        opts
      )
    )
  end
end
