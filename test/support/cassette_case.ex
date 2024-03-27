defmodule Test.Support.CassetteCase do
  @moduledoc """
    Enables invocations of cassettes stored in @cassettes_dir, like:
      use_cassette "time_com_27032024"
  """
  use ExUnit.CaseTemplate

  @cassettes_dir "test/support/cassettes"

  using do
    quote do
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

      import Test.Support.CassetteCase
    end
  end

  setup do
    HTTPoison.start()
    ExVCR.Config.cassette_library_dir(@cassettes_dir)
    :ok
  end
end
