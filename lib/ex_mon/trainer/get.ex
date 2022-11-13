defmodule ExMon.Trainer.Get do
  alias ExMon.{Repo, Trainer}

  def call(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Couldn't find Trainer matching id: #{uuid}!"}
      struct -> {:ok, struct}
    end
  end
end
