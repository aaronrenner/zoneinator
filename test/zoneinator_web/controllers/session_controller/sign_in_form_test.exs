defmodule ZoneinatorWeb.SessionController.SignInFormTest do
  use Zoneinator.DataCase, async: true

  alias Ecto.Changeset
  alias ZoneinatorWeb.SessionController.SignInForm

  test "changeset/0 returns a new ecto changeset" do
    assert %Changeset{} = SignInForm.changeset()
  end

  test "run/1 returns :ok with valid email and password" do
    email = "a@a.com"
    password = "password"

    :ok = Zoneinator.register_user(email, password)

    assert :ok = SignInForm.run(%{"email" => email, "password" => password})
  end

  test "run/1 returns {:error, changeset} when missing email and password" do
    assert {:error, changeset} = SignInForm.run(%{})
    assert changeset.changes == %{}
  end

  test "run/1 returns {:error, changeset} with invalid email and password" do
    assert {:error, changeset} =
             SignInForm.run(%{"email" => "foo@example.com", "password" => "super secret"})

    assert changeset.changes == %{}
  end
end
