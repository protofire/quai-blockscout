defmodule BlockScoutWeb.API.V2.ExternalTransactionView do
  use BlockScoutWeb, :view

  alias BlockScoutWeb.API.V2.Helper

  def render("external_transaction.json", %{transaction: transaction, conn: _conn}) do
    prepare_transaction(transaction)
  end

  def render("external_transactions.json", %{transactions: transactions, next_page_params: next_page_params}) do
    %{
      "items" => Enum.map(transactions, &prepare_transaction/1),
      "next_page_params" => next_page_params
    }
  end

  def render("external_transactions.json", %{transactions: transactions, conn: _conn}) do
    Enum.map(transactions, &prepare_transaction/1)
  end

  defp prepare_transaction(transaction) do
    %{
      "hash" => transaction.hash,
      "block_number" => transaction.block_number,
      "from_address" => Helper.address_with_info(nil, transaction.from_address, transaction.from_address_hash, false),
      "to_address" => Helper.address_with_info(nil, transaction.to_address, transaction.to_address_hash, false),
      "value" => transaction.value,
      "gas_price" => transaction.gas_price,
      "gas_used" => transaction.gas_used,
      "nonce" => transaction.nonce,
      "block_hash" => transaction.block_hash,
      "status" => transaction.status,
      "input" => transaction.input,
      "cumulative_gas_used" => transaction.cumulative_gas_used,
      "error" => transaction.error,
      "index" => transaction.index,
      "nonce" => transaction.nonce,
      "r" => transaction.r,
      "s" => transaction.s,
      "status" => transaction.status,
      "v" => transaction.v,
      "revert_reason" => transaction.revert_reason,
      "max_priority_fee_per_gas" => transaction.max_priority_fee_per_gas,
      "max_fee_per_gas" => transaction.max_fee_per_gas,
      "type" => transaction.type
    }
  end
end