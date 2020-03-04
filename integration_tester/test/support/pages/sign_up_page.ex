defmodule Zoneinator.IntegrationTester.TestSupport.Pages.SignUpPage do
  @moduledoc false
  use Wallaby.DSL

  import ExUnit.Assertions

  @email_field_error_text Query.css("[data-phx-error-for=sign_up_form_email]")
  @password_field_error_text Query.css("[data-phx-error-for=sign_up_form_password]")

  def fill_in_email(session, email) do
    fill_in(session, Query.text_field("Email"), with: email)
  end

  def fill_in_password(session, password) do
    fill_in(session, Query.text_field("Password"), with: password)
  end

  def click_sign_up_button(session) do
    click(session, Query.button("Register"))
  end

  def assert_email_field_error(session, :is_blank) do
    assert Browser.text(session, @email_field_error_text) == "can't be blank"

    session
  end

  def assert_password_field_error(session, :is_blank) do
    assert Browser.text(session, @password_field_error_text) == "can't be blank"

    session
  end
end
