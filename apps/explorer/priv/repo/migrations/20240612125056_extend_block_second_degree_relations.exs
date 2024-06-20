defmodule Explorer.Repo.Migrations.ExtendBlockSecondDegreeRelations do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE block_second_degree_relations DROP CONSTRAINT block_second_degree_relations_pkey"

    alter table(:block_second_degree_relations) do
      add(:id, :bigserial, primary_key: true)
      add(:work_object, :map, null: true)
      add(:number, :integer, null: true)

      modify(:nephew_hash, :bytea, null: false, primary_key: false)
      modify(:uncle_hash, :bytea, null: true, primary_key: false)
    end

    create(index(:block_second_degree_relations, [:number]))
  end
end
