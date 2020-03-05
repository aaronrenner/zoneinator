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

  @doc """
  Checks if the given credentials are valid
  """
  @spec valid_credentials?(String.t(), String.t()) :: boolean
  def valid_credentials?(email, password) when is_binary(email) and is_binary(password) do
    case fetch_user_by_email(email) do
      {:ok, %User{password_hash: password_hash}} ->
        Argon2.verify_pass(password, password_hash)

      {:error, :not_found} ->
        Argon2.no_user_verify()
        false
    end
  end

  @spec fetch_user_by_email(String.t()) :: {:ok, User.t()} | {:error, :not_found}
  defp fetch_user_by_email(email) when is_binary(email) do
    User
    |> Repo.get_by(email: email)
    |> case do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end
end
