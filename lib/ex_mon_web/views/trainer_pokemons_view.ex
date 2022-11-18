defmodule ExMonWeb.TrainerPokemonsView do
  alias ExMon.{Trainer, Trainer.Pokemon}
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

  def render("show.json", %{
        trainer_pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          trainer: %Trainer{id: trainer_id, name: trainer_name},
          weight: weight,
          inserted_at: inserted_at
        }
      }) do
    %{
      trainer_pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        trainer: %{id: trainer_id, name: trainer_name},
        weight: weight,
        inserted_at: inserted_at
      }
    }
  end
end
