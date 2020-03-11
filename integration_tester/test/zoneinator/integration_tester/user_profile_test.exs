defmodule Zoneinator.IntegrationTester.UserProfileTest do
  use ExUnit.Case, async: true
  use Wallaby.DSL

  alias Zoneinator.IntegrationTester.TestSupport.TestData
  alias Zoneinator.IntegrationTester.TestSupport.Pages.SignUpPage
  alias Zoneinator.IntegrationTester.TestSupport.Site

  defmodule ProfilePage do
    @moduledoc false

    use Wallaby.DSL

    def assert_has_email(session, email) do
      assert_text(session, email)
    end
  end

  @tag :skip
  test "log in/log out works" do
    email = TestData.generate_email()
    password = "password"

    {:ok, session} = Wallaby.start_session()

    session
    |> SignUpPage.register_user(email, password)
    |> Site.click_profile_link()
    |> ProfilePage.assert_has_email(email)
  end
end
