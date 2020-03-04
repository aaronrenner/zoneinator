defmodule ZoneinatorWeb.SessionController do
  use ZoneinatorWeb, :controller

  alias ZoneinatorWeb.Authentication

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
