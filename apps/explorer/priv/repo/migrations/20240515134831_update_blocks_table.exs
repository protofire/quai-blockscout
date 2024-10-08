defmodule Explorer.Repo.Migrations.UpdateBlocksTable do
  use Ecto.Migration

  def change do
    alter table(:blocks) do
      add(:manifest_hash_full, {:array, :bytea})
      add(:number_full, {:array, :bytea})
      add(:parent_hash_full, {:array, :bytea})
      add(:etx_rollup_root, :bytea)
      add(:transactions_root, :bytea)
      add(:outbound_etxs_root, :bytea)
      add(:sub_manifest, {:array, :bytea})
      add(:location, :string)
      add(:total_entropy, :bytea)
      add(:parent_entropy, :bytea)
      add(:parent_entropy_full, {:array, :bytea})
      add(:parent_delta_entropy, :bytea)
      add(:parent_delta_entropy_full, {:array, :bytea})
      add(:evm_root, :bytea)
      add(:utxo_root, :bytea)
      add(:etx_set_root, :bytea)
      add(:parent_uncled_delta_entropy, {:array, :binary})
      add(:efficiency_score, :decimal)
      add(:threshold_count, :decimal)
      add(:expansion_number, :decimal)
      add(:etx_eligible_slices, :bytea)
      add(:prime_terminus_hash, :bytea)
      add(:interlink_root_hash, :bytea)
      add(:uncled_entropy, :decimal)
      add(:interlink_hashes, {:array, :bytea})
      add(:quai_state_size, :decimal)
      add(:state_limit, :decimal)
      add(:state_used, :decimal)
      add(:exchange_rate, :decimal)
      add(:quai_to_qi, :decimal)
      add(:qi_to_quai, :decimal)
      add(:secondary_coinbase, :bytea)
      add(:wo_header, :map)
    end
  end
end
