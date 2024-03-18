defmodule PrivateAPI.V1.Views do
  @moduledoc false

  def json_view do
    quote do
      use Phoenix.View,
        root: "private_api/v1/templates/json",
        namespace: PrivateAPI.V1.Views.JSON
    end
  end


  def dynamic_view_module_for_controller_name(controller_name) do
    view_name = String.replace(Atom.to_string(controller_name), "Controller", "View")
    String.to_atom(view_name)
  end


  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end