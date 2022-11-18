defmodule ExMon.Trainer.Pokemon.Get do
  alias ExMon.{Repo, Trainer.Pokemon}

  def call(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, "Couldn't find Trainer Pokemon matching id: #{uuid}!"}
      struct -> {:ok, Repo.preload(struct, :trainer)}
    end
  end
end
