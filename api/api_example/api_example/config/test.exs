use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api_example, ApiExampleWeb.Endpoint,
  http: [port: 4001],
  server: true

# Add the following lines at the end of the file
config :hound, driver: "chrome_driver"
config :api_example, sql_sandbox: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :api_example, ApiExample.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "api_example_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
