defmodule PublicAPI.V1.Views do
  @moduledoc false

  def json_view do
    quote do
      use Phoenix.View,
        root: "public_api/v1/templates/json",
        namespace: PublicAPI.V1.Views.JSON
    end
  end

  @doc """
  WhateverController => WhateverView. Called from the related Controllers module.
  """
  def determine_view_name_from_controller_name(controller_name) do
    view_name = String.replace(Atom.to_string(controller_name), "Controller", "View")

    String.to_atom(view_name)
  end


  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
