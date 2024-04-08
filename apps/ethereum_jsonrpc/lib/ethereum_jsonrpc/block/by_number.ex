defmodule EthereumJSONRPC.Block.ByNumber do
  @moduledoc """
  Block format as returned by [`eth_getBlockByNumber`](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbyhash)
  """

  import EthereumJSONRPC, only: [integer_to_quantity: 1]

  alias EthereumJSONRPC.Transport

  @spec request(map(), boolean(), boolean()) :: Transport.request()
  def request(%{id: id, number: number}, hydrated \\ true, int_to_qty \\ true) do
    block_number =
      if is_list(number) do
        integer_to_quantity(Enum.at(number, String.to_integer(System.get_env("CHAIN_INDEX"))))
      else
        if int_to_qty do
          integer_to_quantity(number)
        else
          number
        end
      end

    EthereumJSONRPC.request(%{id: id, method: "quai_getBlockByNumber", params: [block_number, hydrated]})
  end
end
