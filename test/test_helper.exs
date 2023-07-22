{:ok, _} = RetryOnStale.Repo.start_link()

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(RetryOnStale.Repo, :manual)
