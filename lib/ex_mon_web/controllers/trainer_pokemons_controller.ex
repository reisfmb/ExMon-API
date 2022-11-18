defmodule ExMonWeb.TrainerPokemonsController do
  use ExMonWeb, :controller

  def create(conn, params) do
    params
    |> ExMon.create_trainer_pokemon()
    |> handle_response(conn, "create.json", :created)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExMon.delete_trainer_pokemon()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ExMon.get_trainer_pokemon()
    |> handle_response(conn, "show.json", :ok)
  end

  defp handle_response({:ok, trainer_pokemon}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer_pokemon: trainer_pokemon)
  end

  defp handle_response({:error, _} = error, conn, _, _) do
    ExMonWeb.FallbackController.call(conn, error)
  end

  defp handle_delete({:ok, _trainer_pokemon}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error, _} = error, conn) do
    ExMonWeb.FallbackController.call(conn, error)
  end
end
