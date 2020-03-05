defmodule Zoneinator do
  @moduledoc """
  Zoneinator main API
  """

  alias Zoneinator.Repo
  alias Zoneinator.User

  @doc """
  Registers a new user.
  """
  @spec register_user(String.t(), String.t()) :: :ok | {:error, :email_already_registered}
  def register_user(email, password) when is_binary(email) and is_binary(password) do
    %User{}
    |> User.changeset(%{email: email, password: password})
    |> Repo.insert()
    |> case do
      {:ok, _user} ->
        :ok

      {:error, _changeset} ->
        {:error, :email_already_registered}
    end
  end
end
