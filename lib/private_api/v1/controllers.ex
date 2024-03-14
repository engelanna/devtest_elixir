defmodule PrivateAPI.V1.Controllers do
  @moduledoc false

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:json],
        namespace: PrivateAPI.V1.Controllers

      import Plug.Conn

      unquote(PrivateAPI.verified_routes())
    end
  end




  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
