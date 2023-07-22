defmodule RetryOnStale do
  def retry_on_stale(fun, opts) do
    max_attempts = Keyword.fetch!(opts, :max_attempts)
    delay_ms = Keyword.fetch!(opts, :delay_ms)

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
