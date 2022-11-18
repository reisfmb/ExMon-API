defmodule ExMon.Trainer.Pokemon.Create do
  alias ExMon.PokeApi
  alias ExMon.Pokemon
  alias ExMon.Trainer
  alias ExMon.Trainer.Pokemon, as: TrainerPokemon
  alias ExMon.Repo
  import Ecto.Query, only: [from: 2]

  def call(%{"name" => name, "trainer_id" => trainer_id} = params) do
    check_if_trainer_exists(name, trainer_id)
    |> get_pokemon_from_poke_api()
    |> build_trainer_pokemon(params)
    |> create_trainer_pokemon()
  end

  defp check_if_trainer_exists(name, trainer_id) do
    query = from t in Trainer, where: t.id == ^trainer_id

    case Repo.exists?(query) do
      true -> {:ok, name}
      false -> {:error, "Trainer with id #{trainer_id} does not exist."}
    end
  end

  defp get_pokemon_from_poke_api({:ok, name}) do
    case PokeApi.Client.get_pokemon(name) do
      {:ok, body} -> {:ok, Pokemon.build(body)}
      {:error, _} = error -> error
    end
  end

  defp get_pokemon_from_poke_api({:error, _} = error), do: error

  defp build_trainer_pokemon({:ok, pokemon}, params) do
    %{
      name: Map.get(pokemon, :name),
      nickname: Map.get(params, "nickname"),
      weight: Map.get(pokemon, :weight),
      types: Map.get(pokemon, :types),
      trainer_id: Map.get(params, "trainer_id")
    }
    |> TrainerPokemon.build()
  end

  defp build_trainer_pokemon({:error, _} = error, _), do: error

  defp create_trainer_pokemon({:ok, struct}), do: Repo.insert(struct)
  defp create_trainer_pokemon({:error, _} = error), do: error
end
