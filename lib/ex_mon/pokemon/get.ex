defmodule ExMon.Pokemon.Get do
  def call(name) do
    case ExMon.PokeApi.Client.get_pokemon(name) do
      {:ok, pokemon} -> ExMon.Pokemon.build(pokemon)
      error -> error
    end
  end
end
