defmodule Explorer.Chain.ExtTransaction do
  @moduledoc "Models the extTransactions field in the Quai network"

  use Explorer.Schema

  require Logger

  alias Ecto.Changeset

  alias Explorer.Chain.{
    Address,
    Block,
    Hash,
    Data,
    Wei
  }

  typed_schema "ext_transactions" do
    field(:block_number, :integer)
    field(:gas, :decimal)
    field(:hash, Hash.Full, primary_key: true)
    field(:etx_index, :string)
    field(:input, Data)
    field(:nonce, :integer) :: non_neg_integer() | nil
    field(:status, :string)
    field(:value, Wei) :: Wei.t() | nil
    field(:etx_type, :string)

    belongs_to(
      :to_address,
      Address,
      foreign_key: :to_address_hash,
      references: :hash,
      type: Hash.Address
    )

    belongs_to(
      :sender_address,
      Address,
      foreign_key: :sender_address_hash,
      references: :hash,
      type: Hash.Address
    )

    belongs_to(:block, Block, foreign_key: :block_hash, references: :hash, type: Hash.Full)
    belongs_to(:parent_block, Block, foreign_key: :parent_block_hash, references: :hash, type: Hash.Full)
  end

  @required_attrs ~w(block_hash block_number parent_block to_address_hash sender_address_hash gas hash etx_index input nonce value etx_type)a

  def changeset(%__MODULE__{} = transaction, attrs \\ %{}) do
    transaction
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    # apply status
    |> foreign_key_constraint(:block_hash)
    |> unique_constraint(:hash)
  end
end
