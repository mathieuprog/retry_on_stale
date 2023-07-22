import Config

config :logger, level: :warn # set to :debug to view SQL queries in logs

config :retry_on_stale,
  ecto_repos: [RetryOnStale.Repo]

config :retry_on_stale, RetryOnStale.Repo,
  username: "postgres",
  password: "postgres",
  database: "retry_on_stale_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  priv: "test/support"
