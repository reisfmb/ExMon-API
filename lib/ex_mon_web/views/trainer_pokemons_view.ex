defmodule ExMonWeb.TrainerPokemonsView do
  alias ExMon.Trainer.Pokemon
  use ExMonWeb, :view

  def render("create.json", %{
        trainer_pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          trainer_id: trainer_id,
          weight: weight,
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Pokemon added to trainer!",
      trainer_pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight,
        inserted_at: inserted_at
      }
    }
  end
end
