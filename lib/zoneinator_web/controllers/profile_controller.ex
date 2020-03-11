defmodule ZoneinatorWeb.ProfileController do
  use ZoneinatorWeb, :controller

  def show(conn, _params) do
    render(conn, :show)
  end
end
