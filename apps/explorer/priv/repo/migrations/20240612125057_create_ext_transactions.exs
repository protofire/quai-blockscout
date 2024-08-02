defmodule Explorer.Repo.Migrations.CreateEtxTransactions do
  use Ecto.Migration

  def change do
    create table(:ext_transactions, primary_key: false) do
      add(:block_number, :integer, null: false)
      add(:gas, :numeric, precision: 100, null: false)
      add(:hash, :bytea, null: false, primary_key: true)
      add(:etx_index, :integer, null: false)
      add(:input, :bytea, null: false)
      add(:nonce, :integer, null: false)
      add(:status, :string, null: false)
      add(:value, :numeric, precision: 100, null: false)
      add(:sender_address_hash, :bytea, null: false)
      add(:to_address_hash, :bytea, null: false)
      add(:parent_block_hash, :bytea, null: false)
      add(:etx_type, :string, null: false)

      add(:block_hash, references(:blocks, column: :hash, type: :bytea), null: false)

      timestamps(null: false, type: :utc_datetime_usec)
    end

    create(index(:ext_transactions, :block_hash))
    create(index(:ext_transactions, :inserted_at))
    create(index(:ext_transactions, :updated_at))
    create(index(:ext_transactions, :status))

    create(
      index(
        :ext_transactions,
        [:sender_address_hash, "block_number DESC NULLS FIRST", "etx_index DESC NULLS FIRST", :hash],
        name: "etx_transactions_sender_address_hash_recent_collated_index"
      )
    )

    create(
      index(
        :ext_transactions,
        [:to_address_hash, "block_number DESC NULLS FIRST", "etx_index DESC NULLS FIRST", :hash],
        name: "etx_transactions_to_address_hash_recent_collated_index"
      )
    )

    create(unique_index(:ext_transactions, [:block_hash, :hash]))
  end
end
