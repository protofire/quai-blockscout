defmodule Explorer.Repo.Migrations.UpdateBlocksTableForGoldenAge do
  use Ecto.Migration

  def change do
    alter table(:blocks) do
      add(:evm_root, :bytea)
      add(:utxo_root, :bytea)
      add(:etx_set_hash, :bytea)
      add(:parent_uncled_sub_delta_s, {:array, :bytea})
      add(:efficiency_score, :bytea)
      add(:threshold_count, :bytea)
      add(:expansion_number, :bytea)
      add(:etx_eligible_slices, :bytea)
      add(:prime_terminus, :bytea)
      add(:interlink_root_hash, :bytea)
      add(:uncled_s, :bytea)
      add(:interlink_hashes, {:array, :bytea})
    end
  end
end
