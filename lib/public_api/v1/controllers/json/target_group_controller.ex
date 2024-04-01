defmodule PublicAPI.V1.Controllers.JSON.TargetGroupController do
  @moduledoc false

  use PublicAPI.V1.Controllers, :json_controller

  alias DevtestElixir.Contexts.TargetGroupContext

  def target_groups_for_country_code(conn, %{"country_code" => country_code}) do
    matched_target_groups = \
      TargetGroupContext.target_groups_for_country_code_based_on_countrys_panel_provider(country_code)

    render(conn, :index, %{target_groups: matched_target_groups})
  end

end
