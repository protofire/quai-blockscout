defmodule Explorer.Repo.Migrations.Quaigrate do
  use Ecto.Migration

  def change do
    alter table(:blocks) do
      add(:manifest_hash_full, {:array, :bytea})
      add(:number_full, {:array, :bytea})
      add(:parent_hash_full, {:array, :bytea})
      add(:ext_rollup_root, :bytea)
      add(:transactions_root, :bytea)
      add(:ext_transactions_root, :bytea)
      add(:sub_manifest, {:array, :bytea})
      add(:location, :string)
      add(:is_prime_coincident, :boolean)
      add(:is_region_coincident, :boolean)
      add(:total_entropy, :bytea)
      add(:parent_entropy, :bytea)
      add(:parent_delta_s, :bytea)
      add(:parent_entropy_full, {:array, :bytea})
      add(:parent_delta_s_full, {:array, :bytea})
    end
  end
end
