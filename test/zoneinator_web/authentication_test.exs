defmodule ZoneinatorWeb.AuthenticationTest do
  use ZoneinatorWeb.ConnCase, async: true

  alias ZoneinatorWeb.Authentication

  test "log_in/1 logs in the current conn", %{conn: conn} do
    conn =
      conn
      |> bypass_through(ZoneinatorWeb.Router)
      |> get("/")

    refute Authentication.logged_in?(conn)

    logged_in_conn = Authentication.log_in(conn)

    assert Authentication.logged_in?(logged_in_conn)

    logged_out_conn = Authentication.log_out(logged_in_conn)

    refute Authentication.logged_in?(logged_out_conn)
  end
end
