defmodule ExMon.Trainer.Update do
  alias ExMon.{Repo, Trainer}

  def call(%{"id" => id} = params) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> update(uuid, params)
    end
  end

  defp update(uuid, params) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Couldn't find Trainer matching id: #{uuid}!"}
      struct -> update_trainer(struct, params)
    end
  end

  defp update_trainer(trainer, params) do
    Trainer.changeset(trainer, params)
    |> Repo.update()
  end
end
