defmodule PrivateAPI.V1.Params do
  @moduledoc false

  def params do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @primary_key false
    end
  end


  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
