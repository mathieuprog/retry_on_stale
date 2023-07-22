defmodule RetryOnStale.Repo do
  use Ecto.Repo,
    otp_app: :retry_on_stale,
    adapter: Ecto.Adapters.Postgres
end
