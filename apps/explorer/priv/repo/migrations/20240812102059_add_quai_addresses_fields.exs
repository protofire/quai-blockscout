defmodule Explorer.Repo.Migrations.AddQuaiAddressesFields do
  use Ecto.Migration

  def change do
    alter table(:addresses) do
      add(:currency, :integer, null: true)
    end
  end
end
