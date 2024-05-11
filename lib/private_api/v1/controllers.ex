defmodule PrivateAPI.V1.Controllers do
  @moduledoc false


  def json_controller do
    quote do
      use Phoenix.Controller

      import Plug.Conn

      plug :put_view,
        PrivateAPI.V1.Views.determine_view_name_from_controller_name(__MODULE__)

      unquote(PrivateAPI.verified_routes())
    end
  end


  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
