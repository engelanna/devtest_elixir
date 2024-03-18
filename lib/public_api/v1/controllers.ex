defmodule PublicAPI.V1.Controllers do
  @moduledoc false


  def json_controller do
    quote do
      use Phoenix.Controller

      plug :put_view,
        PublicAPI.V1.Views.dynamic_view_module_for_controller_name(__MODULE__)

      import Plug.Conn

      unquote(PublicAPI.verified_routes())
    end
  end


  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
