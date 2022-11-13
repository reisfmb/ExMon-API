defmodule ExMonWeb.TrainersView do
  alias ExMon.Trainer
  use ExMonWeb, :view

  def render("create.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}
      }) do
    %{
      message: "Trainer created!",
      trainer: %{id: id, name: name, inserted_at: inserted_at}
    }
  end

  def render("show.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}
      }) do
    %{
      trainer: %{id: id, name: name, inserted_at: inserted_at}
    }
  end

  def render("update.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}
      }) do
    %{
      message: "Trainer updated!",
      trainer: %{id: id, name: name, inserted_at: inserted_at}
    }
  end
end
