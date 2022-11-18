defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many(:pokemon, ExMon.Trainer.Pokemon)
    timestamps()
  end

  @required [:name, :password]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  def changeset(trainer, params), do: create_changeset(trainer, params)

  defp create_changeset(module_or_trainer, params) do
    module_or_trainer
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:password, min: 6)
    |> change_password_hash()
    |> delete_change_password()
  end

  defp change_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp change_password_hash(changeset), do: changeset

  defp delete_change_password(%Ecto.Changeset{valid?: true} = changeset) do
    delete_change(changeset, :password)
  end

  defp delete_change_password(changeset), do: changeset
end
