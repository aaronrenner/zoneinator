defmodule ZoneinatorWeb.Router do
  use ZoneinatorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZoneinatorWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController, only: [:new, :create]
    resources "/session", SessionController, singleton: true, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ZoneinatorWeb do
  #   pipe_through :api
  # end
end
