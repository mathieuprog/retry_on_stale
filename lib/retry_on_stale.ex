defmodule RetryOnStale do
  def retry_on_stale(fun, opts \\ []) do
    max_attempts = Keyword.get(opts, :max_attempts, 5)
    delay_ms = Keyword.get(opts, :delay_ms, 100)

    do_retry_on_stale(fun, max_attempts, delay_ms, 1)
  end

  defp do_retry_on_stale(fun, max_attempts, delay_ms, attempt) do
    try do
      fun.(attempt)
    rescue
      e in Ecto.StaleEntryError ->
        if attempt < max_attempts do
          :timer.sleep(delay_ms)
          do_retry_on_stale(fun, max_attempts, delay_ms, attempt + 1)
        else
          reraise e, __STACKTRACE__
        end
    end
  end
end
