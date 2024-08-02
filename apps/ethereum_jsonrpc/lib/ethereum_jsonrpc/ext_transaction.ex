defmodule EthereumJSONRPC.ExtTransaction do
  @moduledoc false

  import EthereumJSONRPC, only: [quantity_to_integer: 1, integer_to_quantity: 1, request: 1]

  alias EthereumJSONRPC
  alias Explorer.Chain.ExtTransaction

  @type elixir :: %{
          String.t() => EthereumJSONRPC.address() | EthereumJSONRPC.hash() | String.t() | non_neg_integer() | nil
        }

  @type params :: %{
          block_hash: EthereumJSONRPC.hash(),
          block_number: non_neg_integer(),
          sender_address_hash: EthereumJSONRPC.address(),
          gas: non_neg_integer(),
          hash: EthereumJSONRPC.hash(),
          etx_index: non_neg_integer(),
          input: String.t(),
          nonce: non_neg_integer(),
          to_address_hash: EthereumJSONRPC.address(),
          value: non_neg_integer(),
          type: non_neg_integer(),
          status: :string
        }

  @spec elixir_to_params(elixir) :: params
  def elixir_to_params(elixir) do
    elixir
    |> do_elixir_to_params()
  end

  def do_elixir_to_params(
        %{
          "blockHash" => block_hash,
          "blockNumber" => block_number,
          "gas" => gas,
          "hash" => hash,
          "input" => input,
          "nonce" => nonce,
          "to" => to,
          "value" => value,
          "type" => type,
          "originatingTxHash" => parent_block_hash,
          "etxIndex" => etx_index,
          "etxType" => etx_type,
          "sender" => sender
        } = _transaction
      ) do
    %{
      block_hash: block_hash,
      parent_block_hash: parent_block_hash,
      block_number: block_number,
      gas: gas,
      hash: hash,
      input: input,
      nonce: nonce,
      to_address_hash: to,
      value: value,
      etx_index: etx_index,
      etx_type: etx_type,
      sender_address_hash: sender,
      transaction_hash: hash,
      type: type,
      status: ExtTransaction.get_pending_status()
    }
  end

  def to_elixir(ext_transaction) when is_map(ext_transaction) do
    Enum.into(ext_transaction, %{}, fn {key, value} -> entry_to_elixir({key, value}) end)
  end

  def to_elixir(_), do: nil

  defp entry_to_elixir({key, value})
       when key in ~w(blockHash sender hash input to etxType originatingTxHash type),
       do: {key, value}

  defp entry_to_elixir({key, quantity})
       when key in ~w(gas nonce value etxIndex blockNumber) and
              quantity != nil do
    {key, quantity_to_integer(quantity)}
  end

  @doc """
  Fields ignored for now: [accessList, transactionIndex]
  """
  defp entry_to_elixir(_) do
    {nil, nil}
  end
end
