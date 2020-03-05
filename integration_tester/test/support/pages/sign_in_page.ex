defmodule Zoneinator.IntegrationTester.TestSupport.Pages.SignInPage do
  @moduledoc false
  use Wallaby.DSL

  import ExUnit.Assertions

  @flash_message Query.css(".alert.alert-danger")

  def fill_in_email(session, email) do
    fill_in(session, Query.text_field("Email"), with: email)
  end

  def fill_in_password(session, password) do
    fill_in(session, Query.text_field("Password"), with: password)
  end

  def click_sign_in_button(session) do
    click(session, Query.button("Sign in"))
  end

  def assert_invalid_credentials(session) do
    assert Browser.text(session, @flash_message) =~ ~r/invalid email.+password/i

    session
  end
end
