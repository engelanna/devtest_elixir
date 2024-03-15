defmodule PrivateAPI.Router do
  @moduledoc false

  use PrivateAPI, :router

  pipeline :v1 do
    plug :accepts, ["json"]
    plug PrivateAPI.V1.Plugs.VerifyToken
  end

  scope "private_api" do
    scope "v1", PrivateAPI.V1.Controllers do
      pipe_through :v1

      get "locations/:country_code", LocationController, :locations_for_country_code, constraints: %{
        country_code: ~r/[A-Z]{2}/
      }

      # get "/target_groups/:country_code", TargetGroupController, :target_groups_for_country_code, constraints: %{
      #   country_code: ~r/[A-Z]{2}/
      # }

      # post "/evaluate_target", TargetController, :evaluate
    end

    # Enable LiveDashboard and Swoosh mailbox preview in development
    if Application.compile_env(:private_api, :dev_routes) do
      # If you want to use the LiveDashboard in production, you should put
      # it behind authentication and allow only admins to access it.
      # If your application does not have an admins-only section yet,
      # you can use Plug.BasicAuth to set up some basic authentication
      # as long as you are also using SSL (which you should anyway).
      import Phoenix.LiveDashboard.Router

      scope "/dev" do
        pipe_through [:fetch_session, :protect_from_forgery]

        live_dashboard "/dashboard", metrics: PrivateAPI.Telemetry
        forward "/mailbox", Plug.Swoosh.MailboxPreview
      end
    end
  end
end
