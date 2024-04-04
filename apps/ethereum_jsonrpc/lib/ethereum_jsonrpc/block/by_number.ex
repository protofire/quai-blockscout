defmodule EthereumJSONRPC.Block.ByNumber do
  @moduledoc """
  Block format as returned by [`eth_getBlockByNumber`](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbyhash)
  """

  import EthereumJSONRPC, only: [integer_to_quantity: 1]

  alias EthereumJSONRPC.Transport

  @spec request(map(), boolean(), boolean()) :: Transport.request()
  def request(%{id: id, number: number}, hydrated \\ true, int_to_qty \\ true) do
    block_number =
      if int_to_qty do
        integer_to_quantity(number)
      else
        number
      end

    # Not sure that this is correct
    if is_list(block_number) do
      EthereumJSONRPC.request(%{
        id: id,
        method: "quai_getBlockByNumber",
        params: [integer_to_quantity(Enum.at(block_number, String.to_integer(System.get_env("CHAIN_INDEX")))), hydrated]
      })
    else
      EthereumJSONRPC.request(%{id: id, method: "quai_getBlockByNumber", params: [block_number, hydrated]})
    end

    # EthereumJSONRPC.request(%{id: id, method: "eth_getBlockByNumber", params: [block_number, hydrated]})
  end
end
