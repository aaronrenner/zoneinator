defmodule Zoneinator.IntegrationTester.SignUpTest do
  use ExUnit.Case
  use Wallaby.DSL

  alias Zoneinator.IntegrationTester.TestSupport.Pages.HomePage
  alias Zoneinator.IntegrationTester.TestSupport.Pages.SignUpPage
  alias Zoneinator.IntegrationTester.TestSupport.Site

  test "signing up the user" do
    {:ok, session} = Wallaby.start_session()

    session
    |> HomePage.visit()
    |> Site.click_sign_up()
    |> SignUpPage.click_sign_up_button()
    |> SignUpPage.assert_email_field_error(:is_blank)
    |> SignUpPage.assert_password_field_error(:is_blank)

    session
    |> SignUpPage.fill_in_email("a@a.com")
    |> SignUpPage.fill_in_password("password")
    |> SignUpPage.click_sign_up_button()
    |> Site.assert_success_message()
    |> Site.assert_logged_in()
    |> Site.log_out()
    |> Site.refute_logged_in()
  end
end
