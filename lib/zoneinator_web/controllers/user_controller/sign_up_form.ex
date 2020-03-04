defmodule ZoneinatorWeb.UserController.SignUpForm do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  def run(params) when is_map(params) do
    changeset = changeset(%__MODULE__{}, params)

    case apply_action(changeset, :insert) do
      {:ok, _form} -> :ok
      {:error, changeset} -> {:error, changeset}
    end
  end

  def changeset do
    changeset(%__MODULE__{}, %{})
  end

  defp changeset(data, params) do
    data
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end
end
