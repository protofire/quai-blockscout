defmodule Explorer.Repo.Migrations.AddQuaiTransactionsFields do
  use Ecto.Migration

  def change do
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_cumalative_gas_used")
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_gas_price")
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_gas_used")
    # ???
    execute("ALTER TABLE transactions DROP CONSTRAINT collated_index")

    alter table(:transactions) do
      add(:chain_id, :integer, null: true)
      add(:inputs, {:array, :map}, null: true)
      add(:outputs, {:array, :map}, null: true)
      add(:utxo_signature, :bytea, null: true)
      add(:etx_type, :integer, null: true)

      modify(:r, :numeric, precision: 100, null: true)
      modify(:s, :numeric, precision: 100, null: true)
      modify(:v, :numeric, precision: 100, null: true)
      modify(:value, :numeric, precision: 100, null: true)
      modify(:from_address_hash, :bytea, null: true)
    end
  end
end
