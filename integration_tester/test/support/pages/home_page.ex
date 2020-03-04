defmodule Zoneinator.IntegrationTester.TestSupport.Pages.HomePage do
  @moduledoc false

  def url, do: "/"

  def visit(session) do
    Wallaby.Browser.visit(session, url())
  end
end
