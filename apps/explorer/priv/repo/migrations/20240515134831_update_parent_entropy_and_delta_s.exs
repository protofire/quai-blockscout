defmodule Explorer.Repo.Migrations.UpdateParentEntropyAndDeltaS do
  use Ecto.Migration

  def change do
    alter table(:blocks) do
      add(:evm_root, :bytea)
      add(:utxo_root, :bytea)
      add(:etx_set_root, :bytea)
      add(:parent_uncled_sub_delta_s, {:array, :binary})
      add(:efficiency_score, :decimal)
      add(:threshold_count, :decimal)
      add(:expansion_number, :decimal)
      add(:etx_eligible_slices, :bytea)
      add(:prime_terminus, :bytea)
      add(:interlink_root_hash, :bytea)
      add(:uncled_s, {:array, :bytea})
      add(:interlink_hashes, {:array, :bytea})
      add(:wo_header, :map)
    end
  end
end
