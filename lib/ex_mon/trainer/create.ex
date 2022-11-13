defmodule ExMon.Trainer.Create do
  alias ExMon.{Repo, Trainer}

  def call(params) do
    params
    |> Trainer.apply_insert()
    |> create_trainer()
  end

  defp create_trainer({:ok, struct}), do: Repo.insert(struct)
  defp create_trainer({:error, _} = error), do: error
end
