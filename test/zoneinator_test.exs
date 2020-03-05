defmodule ZoneinatorTest do
  use Zoneinator.DataCase, async: true

  test "register_user/2 returns :ok on success" do
    assert :ok = Zoneinator.register_user("a@a.com", "password")
  end

  test "register_user/2 returns {:error, :email_already_registered} on duplicate email" do
    email = "a@a.com"
    :ok = Zoneinator.register_user(email, "password")

    assert {:error, :email_already_registered} = Zoneinator.register_user(email, "password")
  end
end
