defmodule ZoneinatorWeb.UserController.SignUpForm do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @type t :: %__MODULE__{
          email: String.t() | nil,
          password: String.t() | nil
        }

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  @spec run(map) :: :ok | {:error, Changeset.t()}
  def run(params) when is_map(params) do
    changeset = changeset(%__MODULE__{}, params)

    case apply_action(changeset, :insert) do
      {:ok, form} ->
        register_user(form, changeset)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @spec changeset :: Changeset.t()
  def changeset do
    changeset(%__MODULE__{}, %{})
  end

  defp changeset(data, params) do
    data
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end

  @spec(register_user(t, Changeset.t()) :: :ok, {:error, Changeset.t()})
  defp register_user(%__MODULE__{email: email, password: password}, changeset) do
    case Zoneinator.register_user(email, password) do
      :ok ->
        :ok

      {:error, :email_already_registered} ->
        changeset =
          %Changeset{changeset | action: :insert}
          |> add_error(:email, "is already registered")

        {:error, changeset}
    end
  end
end
