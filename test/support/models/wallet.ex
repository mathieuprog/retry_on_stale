defmodule RetryOnStale.Wallet do
  use Ecto.Schema

  schema "wallets" do
    field :lock_version, :integer, default: 1
    field :balance_amount, :decimal, default: Decimal.new(0)
  end
end
