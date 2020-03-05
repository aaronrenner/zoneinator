defmodule Zoneinator.User do
  @moduledoc false

  use Ecto.Schema

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
  end

  def changeset(data, params) do
    data
    |> Changeset.cast(params, [:email])
    |> Changeset.unique_constraint(:email)
  end
end
