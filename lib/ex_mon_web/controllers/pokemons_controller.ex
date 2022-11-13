defmodule ExMonWeb.PokemonsController do
  use ExMonWeb, :controller

  def show(conn, %{"name" => name}) do
    name |> ExMon.get_pokemon() |> handle_response(conn)
  end

  defp handle_response({:ok, pokemon}, conn) do
    conn
    |> put_status(:ok)
    |> json(pokemon)
  end

  defp handle_response({:error, _} = error, conn) do
    ExMonWeb.FallbackController.call(conn, error)
  end
end
