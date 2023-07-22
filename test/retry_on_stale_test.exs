defmodule RetryOnStaleTest do
  use ExUnit.Case

  import RetryOnStale, only: [retry_on_stale: 2]

  alias RetryOnStale.Repo
  alias RetryOnStale.Wallet

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RetryOnStale.Repo)
  end

  defp increase_wallet_balance(wallet, amount) do
    new_balance = Decimal.add(wallet.balance_amount, amount)

    wallet
    |> Ecto.Changeset.change(balance_amount: new_balance)
    |> Ecto.Changeset.optimistic_lock(:lock_version)
    |> Repo.update!()
  end

  test "retry on stale" do
    wallet = Repo.insert!(%Wallet{balance_amount: Decimal.new(0)})

    amount_to_add = Decimal.new(10)

    Enum.each(1..100, fn _ ->
      Task.start(fn ->
        retry_on_stale(
          fn attempt ->
            wallet = if attempt == 1, do: wallet, else: Repo.get!(Wallet, wallet.id)

            increase_wallet_balance(wallet, amount_to_add)
          end,
          max_attempts: 100, delay_ms: 100
        )
      end)
    end)

    Process.sleep(5000)

    wallet = Repo.get(Wallet, wallet.id)
    assert wallet.balance_amount == Decimal.new(1000)
  end
end
