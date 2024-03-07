defmodule DevtestElixir.Contexts.UTCTimestampNoMicroseconds do
  @moduledoc false

  def new do
    DateTime.utc_now() |> DateTime.truncate(:second)
  end

end
