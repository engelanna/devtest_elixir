defmodule PrivateAPI.V1.Controllers.LocationController do
  @moduledoc false

  use PrivateAPI.V1.Controllers, :controller

  import PrivateAPI.V1.Views.JSON.LocationView

  def locations_for_country_code(_conn, %{country_code: _country_code}) do
    # LocationContext

    # location = Repo.get!(Location, id)
    # render(conn, "show.json", location: location)
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  # def index(conn, _params) do
  #   examples = Repo.all(Location)
  #   render(conn, "index.json", examples: examples)
  # end


  # def create(conn, %{"location" => example_params}) do
  #   changeset = Location.changeset(%Location{}, example_params)

  #   case Repo.insert(changeset) do
  #     {:ok, location} ->
  #       conn
  #       |> put_status(:created)
  #       |> put_resp_header("location", Routes.example_path(conn, :show, location))
  #       |> render("show.json", location: location)

  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(YourAppWeb.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def update(conn, %{"id" => id, "location" => example_params}) do
  #   location = Repo.get!(Location, id)
  #   changeset = Location.changeset(location, example_params)

  #   case Repo.update(changeset) do
  #     {:ok, location} ->
  #       render(conn, "show.json", location: location)

  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(YourAppWeb.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   location = Repo.get!(Location, id)
  #   Repo.delete!(location)
  #   send_resp(conn, :no_content, "")
  # end
end
