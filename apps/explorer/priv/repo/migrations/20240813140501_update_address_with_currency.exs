defmodule Explorer.Repo.Migrations.UpdateAddressWithCurrency do
  use Ecto.Migration
  import Ecto.Query

  alias Explorer.Repo
  alias Explorer.Chain.{Hash, Address}

  def up do
    from(a in Address)
    |> Repo.all()
    |> Enum.each(fn address ->
      Address.changeset(address, Map.from_struct(address))
      |> Repo.update()
    end)
  end

  def down do
    :ok
  end
end
