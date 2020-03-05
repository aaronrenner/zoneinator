defmodule ZoneinatorWeb.UserController.SignUpFormTest do
  use Zoneinator.DataCase, async: true

  alias Ecto.Changeset
  alias ZoneinatorWeb.UserController.SignUpForm

  test "run/1 with valid params returns :ok" do
    email = "a@a.com"
    password = "password"

    assert :ok = SignUpForm.run(%{"email" => email, "password" => password})
  end

  test "run/1 when email is already registered" do
    email = "a@a.com"
    password = "password"
    :ok = SignUpForm.run(%{"email" => email, "password" => password})

    assert {:error, changeset} = SignUpForm.run(%{"email" => email, "password" => password})
    assert %{email: ["is already registered"]} == errors_on(changeset)
    assert changeset.action == :insert
  end

  test "run/1 with no params returns an invalid changeset" do
    assert {:error, changeset} = SignUpForm.run(%{})

    assert %{email: ["can't be blank"], password: ["can't be blank"]} == errors_on(changeset)
    assert changeset.action == :insert
  end

  test "changeset/0 returns an ecto changeset" do
    assert %Changeset{} = SignUpForm.changeset()
  end
end
