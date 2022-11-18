defmodule ExMon.Trainer.Pokemon.Delete do
  alias ExMon.{Repo, Trainer.Pokemon}

  def call(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, "Couldn't find Trainer Pokemon matching id: #{uuid}!"}
      struct -> Repo.delete(struct)
    end
  end
end
