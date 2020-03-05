defmodule ZoneinatorWeb.SessionController.SignInForm do
  @moduledoc false

  use Ecto.Schema

  alias Ecto.Changeset

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  @spec run(map) :: :ok | {:error, Changeset.t()}
  def run(params) when is_map(params) do
    changeset = changeset(%__MODULE__{}, params)

    with {:ok, form} <- Changeset.apply_action(changeset, :insert),
         true <- valid_credentials?(form) do
      :ok
    else
      _ ->
        {:error, changeset()}
    end
  end

  def changeset do
    changeset(%__MODULE__{}, %{})
  end

  defp changeset(data, params) do
    data
    |> Changeset.cast(params, [:email, :password])
    |> Changeset.validate_required([:email, :password])
  end

  defp valid_credentials?(%__MODULE__{email: email, password: password}) do
    Zoneinator.valid_credentials?(email, password)
  end
end
