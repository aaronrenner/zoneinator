defmodule Zoneinator.IntegrationTester.TestSupport.Site do
  @moduledoc false

  use Wallaby.DSL

  @sign_out_link Query.link("Sign out")
  @sign_up_link Query.link("Sign up")
  @sign_in_link Query.link("Sign in")

  def click_sign_up(session) do
    click(session, @sign_up_link)
  end

  def click_sign_in(session) do
    click(session, @sign_in_link)
  end

  def log_out(session) do
    click(session, @sign_out_link)
  end

  def assert_logged_in(session) do
    assert_has(session, @sign_out_link)
  end

  def refute_logged_in(session) do
    refute_has(session, @sign_out_link)
  end

  def assert_success_message(session) do
    assert_has(session, Query.css(".alert.alert-info"))
  end
end
