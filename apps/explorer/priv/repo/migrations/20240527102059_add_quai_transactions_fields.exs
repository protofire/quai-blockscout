defmodule Explorer.Repo.Migrations.AddQuaiTransactionsFields do
  use Ecto.Migration

  def change do
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_cumalative_gas_used")
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_gas_price")
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_gas_used")
    # ???
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_index")
    execute("DROP INDEX transactions_block_hash_index_index")

    alter table(:transactions) do
      add(:chain_id, :integer, null: true)
      add(:inputs, {:array, :map}, null: true)
      add(:outputs, {:array, :map}, null: true)
      add(:utxo_signature, :bytea, null: true)
      add(:is_etx, :boolean, null: false, default: false)
      add(:etx_index, :integer, null: true)
      add(:etx_type, :integer, null: true)
      add(:originating_tx_hash, :bytea, null: true)

      modify(:r, :numeric, precision: 100, null: true)
      modify(:s, :numeric, precision: 100, null: true)
      modify(:v, :numeric, precision: 100, null: true)
      modify(:value, :numeric, precision: 100, null: true)
      modify(:from_address_hash, :bytea, null: true)
    end

    create(unique_index(:transactions, [:block_hash, :index, :is_etx]))
  end
end
