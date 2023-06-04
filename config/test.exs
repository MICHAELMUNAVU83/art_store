import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :art_store, ArtStore.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "art_store_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :art_store, ArtStoreWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "j7oWKeUvPGtPX/V7R0vNxWIKxooIgYNttdoEYqEn+2uNjhuIY1w7fEjJmW9S6bYm",
  server: false

# In test we don't send emails.
config :art_store, ArtStore.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
