defmodule Explorer.Chain.Import.Runner.ExtTransactions do
  @moduledoc false

  require Ecto.Query

  import Ecto.Query, only: [from: 2]

  alias Ecto.{Multi, Repo}
  alias Explorer.Chain.{Block, Hash, Import, ExtTransaction}
  alias Explorer.Prometheus.Instrumenter

  @behaviour Import.Runner

  # milliseconds
  @timeout 60_000

  @type imported :: [Hash.Full.t()]

  @impl Import.Runner
  def ecto_schema_module, do: ExtTransaction

  @impl Import.Runner
  def option_key, do: :ext_transactions

  @impl Import.Runner
  def imported_table_row do
    %{
      value_type: "[#{ecto_schema_module()}.t()]",
      value_description: "List of `t:#{ecto_schema_module()}.t/0`s"
    }
  end

  @impl Import.Runner
  def run(multi, changes_list, %{timestamps: timestamps} = options) do
    multi
    |> Multi.run(:insert_ext_transactions, fn repo, _ ->
      Instrumenter.block_import_stage_runner(
        fn -> insert(repo, changes_list, options) end,
        :block_referencing,
        :ext_transactions,
        :inset_ext_transactions
      )
    end)
  end

  @impl Import.Runner
  def timeout, do: @timeout

  @spec insert(Repo.t(), [map()], %{
          required(:timeout) => timeout,
          required(:timestamps) => Import.timestamps(),
          required(:token_transfer_external_transaction_hash_set) => MapSet.t()
        }) :: {:ok, [Hash.t()]}
  defp insert(
         repo,
         changes_list,
         %{
           timestamps: timestamps
         } = options
       )
       when is_list(changes_list) do
    Import.insert_changes_list(
      repo,
      changes_list,
      for: ExtTransaction,
      returning: true,
      timestamps: timestamps
    )
  end
end
