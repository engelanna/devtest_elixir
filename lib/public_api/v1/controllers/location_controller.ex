defmodule PublicAPI.V1.Controllers.LocationController do
  @moduledoc false

  use PublicAPI, :controller

  alias DevtestElixir.Repo

  # def index(conn, _params) do
  #   examples = Repo.all(Example)
  #   render(conn, "index.json", examples: examples)
  # end

  def show(conn, %{"id" => id}) do
    example = Repo.get!(Example, id)
    render(conn, "show.json", example: example)
  end

  # def create(conn, %{"example" => example_params}) do
  #   changeset = Example.changeset(%Example{}, example_params)

  #   case Repo.insert(changeset) do
  #     {:ok, example} ->
  #       conn
  #       |> put_status(:created)
  #       |> put_resp_header("location", Routes.example_path(conn, :show, example))
  #       |> render("show.json", example: example)

  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(YourAppWeb.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def update(conn, %{"id" => id, "example" => example_params}) do
  #   example = Repo.get!(Example, id)
  #   changeset = Example.changeset(example, example_params)

  #   case Repo.update(changeset) do
  #     {:ok, example} ->
  #       render(conn, "show.json", example: example)

  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(YourAppWeb.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   example = Repo.get!(Example, id)
  #   Repo.delete!(example)
  #   send_resp(conn, :no_content, "")
  # end
end
