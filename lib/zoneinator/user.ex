defmodule Zoneinator.User do
  @moduledoc false

  use Ecto.Schema

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
  end

  @type t :: %__MODULE__{
          email: String.t() | nil,
          password: String.t() | nil,
          password_hash: String.t() | nil
        }

  def changeset(data, params) do
    data
    |> Changeset.cast(params, [:email, :password])
    |> Changeset.unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    Changeset.change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
