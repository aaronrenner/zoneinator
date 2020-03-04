defmodule ZoneinatorWeb.LayoutView do
  use ZoneinatorWeb, :view

  alias ZoneinatorWeb.Authentication

  alias Plug.Conn

  @spec logged_in?(Conn.t()) :: boolean
  def logged_in?(conn) do
    Authentication.logged_in?(conn)
  end
end
