defmodule ExMon.PokeApi.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def get_pokemon(name) do
    "/pokemon/#{name}" |> get() |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}

  defp handle_get({:ok, %Tesla.Env{status: 404, url: url}}),
    do: {:error, "Couldn't find pokemon at: #{url}"}

  defp handle_get({:error, _} = error), do: error
end
