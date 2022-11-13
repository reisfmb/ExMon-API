defmodule ExMon.PokeApi.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def get_pokemon(name) do
    "/pokemon/#{name}" |> get() |> handle_get(name)
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}, _), do: {:ok, body}

  defp handle_get({:ok, %Tesla.Env{status: 404}}, name),
    do: {:error, "Couldn't find pokemon with name: #{name}"}

  defp handle_get({:error, _} = error, _), do: error
end
