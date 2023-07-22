defmodule RetryOnStale.CreateTables do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :lock_version, :integer, default: 1
      add :balance_amount, :numeric, null: false, default: 0
    end
  end
end
