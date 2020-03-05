defmodule Zoneinator.IntegrationTester.AuthenticationTest do
  use ExUnit.Case, async: true
  use Wallaby.DSL

  alias Zoneinator.IntegrationTester.TestSupport.TestData
  alias Zoneinator.IntegrationTester.TestSupport.Pages.SignInPage
  alias Zoneinator.IntegrationTester.TestSupport.Pages.SignUpPage
  alias Zoneinator.IntegrationTester.TestSupport.Site

  test "log in/log out works" do
    email = TestData.generate_email()
    password = "password"

    {:ok, session} = Wallaby.start_session()

    session
    |> SignUpPage.register_user(email, password)
    |> Site.log_out()
    |> Site.click_sign_in()
    |> SignInPage.click_sign_in_button()
    |> SignInPage.assert_invalid_credentials()

    session
    |> SignInPage.fill_in_email(email)
    |> SignInPage.fill_in_password("invalid")
    |> SignInPage.click_sign_in_button()
    |> SignInPage.assert_invalid_credentials()

    session
    |> SignInPage.fill_in_email(email)
    |> SignInPage.fill_in_password(password)
    |> SignInPage.click_sign_in_button()
    |> Site.assert_logged_in()
  end
end
