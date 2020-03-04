defmodule ZoneinatorWeb.Authentication do
  @moduledoc false

  alias Plug.Conn

  @session_key "_zoneinator-login"

  @spec logged_in?(Conn.t()) :: boolean
  def logged_in?(%Conn{} = conn) do
    Conn.get_session(conn, @session_key) == "logged_in"
  end

  @spec log_in(Conn.t()) :: Conn.t()
  def log_in(%Conn{} = conn) do
    Conn.put_session(conn, @session_key, "logged_in")
  end

  @spec log_out(Conn.t()) :: Conn.t()
  def log_out(%Conn{} = conn) do
    Conn.delete_session(conn, @session_key)
  end
end
