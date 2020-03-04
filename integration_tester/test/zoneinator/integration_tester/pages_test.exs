defmodule Zoneinator.IntegrationTester.PagesTest do
  use ExUnit.Case, async: true
  use Wallaby.DSL

  test "visiting the home page works correctly" do
    {:ok, session} = Wallaby.start_session()

    session
    |> visit("/")
    |> assert_text("Welcome to Phoenix!")
  end
end
