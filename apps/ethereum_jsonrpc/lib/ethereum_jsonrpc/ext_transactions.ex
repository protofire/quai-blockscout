defmodule EthereumJSONRPC.ExtTransactions do
  alias EthereumJSONRPC.ExtTransaction

  @type elixir :: [ExtTransaction.elixir()]
  @type params :: [ExtTransaction.params()]
  @type t :: [ExtTransaction.t()]

  def elixir_to_params(elixir) when is_list(elixir) do
    Enum.map(elixir, &ExtTransaction.elixir_to_params/1)
  end

  def to_elixir(ext_transactions, block_timestamp \\ nil) when is_list(ext_transactions) do
    ext_transactions
    |> Enum.map(&ExtTransaction.to_elixir(&1, block_timestamp))
    |> Enum.filter(&(!is_nil(&1)))
  end
end
