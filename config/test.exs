import Config

# Configure your database
config :zoneinator, Zoneinator.Repo,
  username: "postgres",
  password: "postgres",
  database: "zoneinator_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :zoneinator, ZoneinatorWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8
