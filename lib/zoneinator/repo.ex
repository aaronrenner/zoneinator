defmodule Zoneinator.Repo do
  use Ecto.Repo,
    otp_app: :zoneinator,
    adapter: Ecto.Adapters.Postgres
end
