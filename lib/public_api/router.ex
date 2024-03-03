defmodule PublicAPI.Router do
  @moduledoc false

  use PublicAPI, :router

  pipeline :default do
    plug :accepts, ["json"]
  end

  scope "/public_api", PublicAPI do
    scope "/v1", V1.Controllers do
      pipe_through :default

      resources "/locations", LocationController, only: [:show]

      scope "/target_groups" do
        get "/:id/:country_code", TargetGroupController, :show
      end
    end

    # Enable LiveDashboard and Swoosh mailbox preview in development
    if Application.compile_env(:public_api, :dev_routes) do
      # If you want to use the LiveDashboard in production, you should put
      # it behind authentication and allow only admins to access it.
      # If your application does not have an admins-only section yet,
      # you can use Plug.BasicAuth to set up some basic authentication
      # as long as you are also using SSL (which you should anyway).
      import Phoenix.LiveDashboard.Router

      scope "/dev" do
        pipe_through [:fetch_session, :protect_from_forgery]

        live_dashboard "/dashboard", metrics: PublicAPI.Telemetry
        forward "/mailbox", Plug.Swoosh.MailboxPreview
      end
    end
  end
end
