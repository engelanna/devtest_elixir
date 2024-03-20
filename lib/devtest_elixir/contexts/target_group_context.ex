defmodule DevtestElixir.Contexts.TargetGroupContext do
  @moduledoc false

  import Ecto.Query

  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup

  def target_groups_for_country_code_based_on_countrys_panel_provider(country_code) do
    Repo.all(
      from target_group in TargetGroup,
        join: panel_provider in assoc(target_group, :panel_provider),
        join: country in assoc(target_group, :countries),
          on: panel_provider.id == country.panel_provider_id,
        where: country.country_code == ^country_code
    )
  end
end
