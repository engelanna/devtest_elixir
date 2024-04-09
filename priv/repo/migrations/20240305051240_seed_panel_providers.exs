defmodule DevtestElixir.Repo.Migrations.SeedPanelProviders do
  use Ecto.Migration

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Contexts.Shared.UTCTimestampNoMicroseconds
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.PanelProvider


  @doc """
  If no PanelProviders present, creates the 3 predefined PanelProviders.
  """
  def up do
    if Repo.aggregate(PanelProvider, :count) == 0 do
      Repo.insert_all(PanelProvider, seeds())
    end
  end

  @doc """
  Deletes the 3 predefined PanelProviders if they are present.
  """
  def down do
    Enum.each(
      seeds(),
      fn seed ->
        Repo.delete_all(
          from(
            pp in PanelProvider,
            where:
              pp.id == ^seed.id and
              pp.pricing_strategy_code == ^seed.pricing_strategy_code
          )
        )
      end
    )
  end


  defp seeds do
    timestamp = UTCTimestampNoMicroseconds.new()

    [
      %{
        id: 1,
        pricing_strategy_code: "count_characters_at_url_then_divide",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: 2,
        pricing_strategy_code: "count_arrays_over_n_elements_at_json_url",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: 3,
        pricing_strategy_code: "count_html_nodes_at_url_then_divide",
        inserted_at: timestamp,
        updated_at: timestamp
      }
    ]
  end
end
