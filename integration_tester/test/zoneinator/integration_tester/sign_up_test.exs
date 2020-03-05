defmodule Zoneinator.IntegrationTester.SignUpTest do
  use ExUnit.Case, async: true
  use Wallaby.DSL

  alias Zoneinator.IntegrationTester.TestSupport.Pages.HomePage
  alias Zoneinator.IntegrationTester.TestSupport.Pages.SignUpPage
  alias Zoneinator.IntegrationTester.TestSupport.Site
  alias Zoneinator.IntegrationTester.TestSupport.TestData

  test "signing up the user" do
    email = TestData.generate_email()
    password = "password"

    {:ok, session_1} = Wallaby.start_session()
    {:ok, session_2} = Wallaby.start_session()

    session_1
    |> SignUpPage.register_user(email, password)

    session_2
    |> HomePage.visit()
    |> Site.click_sign_up()
    |> SignUpPage.click_sign_up_button()
    |> SignUpPage.assert_email_field_error(:is_blank)
    |> SignUpPage.assert_password_field_error(:is_blank)
    |> SignUpPage.fill_in_email(email)
    |> SignUpPage.fill_in_password(password)
    |> SignUpPage.click_sign_up_button()
    |> SignUpPage.assert_email_field_error(:is_already_registered)

    session_2
    |> SignUpPage.fill_in_email(TestData.generate_email())
    |> SignUpPage.fill_in_password("password")
    |> SignUpPage.click_sign_up_button()
    |> Site.assert_success_message()
    |> Site.assert_logged_in()
    |> Site.log_out()
    |> Site.refute_logged_in()
  end
end
