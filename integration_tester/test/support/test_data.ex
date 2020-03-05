defmodule Zoneinator.IntegrationTester.TestSupport.TestData do
  @moduledoc false

  @test_email_prefix "test-user"

  def generate_email do
    "#{@test_email_prefix}-#{System.os_time()}-#{random_string(8)}@example.com"
  end

  defp random_string(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode16()
    |> binary_part(0, length)
  end
end
