defmodule EthereumJSONRPC.Uncle do
  @moduledoc """
  [Uncle](https://github.com/ethereum/wiki/wiki/Glossary#ethereum-blockchain).

  An uncle is a block that didn't make the main chain due to them being validated slightly behind what became the main
  chain.
  """

  @type elixir :: %{String.t() => EthereumJSONRPC.hash() | non_neg_integer()}

  @typedoc """
  * `"hash"` - the hash of the uncle block.
  * `"nephewHash"` - the hash of the nephew block that included `"hash` as an uncle.
  * `"index"` - the index of the uncle block within the nephew block.
  """
  @type t :: %{String.t() => EthereumJSONRPC.hash()}

  @type params :: %{
                    nephew_hash: EthereumJSONRPC.hash(),
                    uncle_hash: EthereumJSONRPC.hash(),
                    index: non_neg_integer(),
                    work_object: map()
                  }

  @doc """
  Converts each entry in `t:elixir/0` to `t:params/0` used in `Explorer.Chain.Uncle.changeset/2`.

      iex> EthereumJSONRPC.Uncle.elixir_to_params(
      ...>   %{
      ...>     "hash" => "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d15273311",
      ...>     "nephewHash" => "0xe52d77084cab13a4e724162bcd8c6028e5ecfaa04d091ee476e96b9958ed6b47",
      ...>     "index" => 0
      ...>   }
      ...> )
      %{
        nephew_hash: "0xe52d77084cab13a4e724162bcd8c6028e5ecfaa04d091ee476e96b9958ed6b47",
        uncle_hash: "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d15273311",
        index: 0
      }

  """
  @spec elixir_to_params(elixir) :: params
  def elixir_to_params(%{"hash" => uncle_hash, "nephewHash" => nephew_hash, "index" => index})
      when is_binary(uncle_hash) and is_binary(nephew_hash) and is_integer(index) do
    %{nephew_hash: nephew_hash, uncle_hash: uncle_hash, index: index}
  end

  @spec elixir_to_params(elixir) :: params
  def elixir_to_params(%{"workObject" => work_object, "nephewHash" => nephew_hash, "index" => index})
      when is_map(work_object) and is_binary(nephew_hash) and is_integer(index) do
    %{nephew_hash: nephew_hash, work_object: work_object, index: index}
  end
end
