defmodule ZoneinatorTest do
  use Zoneinator.DataCase, async: true

  alias Zoneinator.User

  test "register_user/2 returns :ok on success" do
    email = "a@.com"
    assert {:ok, user_id} = Zoneinator.register_user(email, "password")

    assert {:ok, %User{id: ^user_id, email: ^email}} = Zoneinator.fetch_user(user_id)
  end

  test "register_user/2 returns {:error, :email_already_registered} on duplicate email" do
    email = "a@a.com"
    :ok = Zoneinator.register_user(email, "password")

    assert {:error, :email_already_registered} = Zoneinator.register_user(email, "password")
  end

  test "fetch_user_id_for_credentials?/2 returns true when email and password is correct" do
    email = "a@a.com"
    password = "password"

    :ok = Zoneinator.register_user(email, password)

    assert Zoneinator.valid_credentials?(email, password)
  end

  test "valid_credentials?/2 returns false when user does not exist for an email" do
    refute Zoneinator.valid_credentials?("foo@example.com", "secret")
  end

  test "valid_credentials?/2 returns when email exists but password is wrong" do
    email = "a@a.com"
    :ok = Zoneinator.register_user(email, "secret")

    refute Zoneinator.valid_credentials?(email, "invalid")
  end
end
