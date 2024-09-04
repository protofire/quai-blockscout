#!/bin/bash

# Local Dev
export DATABASE_URL=postgresql://blockscout:blockscout@localhost:5432/blockscout
export SECRET_KEY_BASE=27Swe6KtEtmN37WyEYRjKWyxYULNtrxlkCEKur4qoV+Lwtk8lafsR16ifz1XBBYj
export API_V2_ENABLED=true
export PORT=3001
export MIX_ENV=dev
export CHAIN_ID="9000"
export COIN=quai
export COIN_NAME=Quai
export SHOW_TESTNET_LABEL="true"
export BLOCKSCOUT_HOST=localhost
export BLOCKSCOUT_PROTOCOL=http
export CHAIN_INDEX="2"
export CHAIN_TYPE=quai
export DISABLE_WEBAPP="true"
export ECTO_USE_SSL="false"
export ETHEREUM_JSONRPC_PENDING_TRANSACTIONS_TYPE=geth
export ETHEREUM_JSONRPC_TRANSPORT=http
export ETHEREUM_JSONRPC_VARIANT=geth
export ETHEREUM_JSONRPC_VARIANT=geth
export ETHEREUM_JSONRPC_WS_URL=ws://rpc.sandbox.quai.network:8200
export FOOTER_LINK_TO_OTHER_EXPLORERS="false"
export NETWORK=Colosseum
export POOL_SIZE="70"
export POOL_SIZE_API="20"

# Indexers
# export BLOCK_RANGES="0..100"
export FIRST_BLOCK=0
export LAST_BLOCK=100
export DISABLE_INDEXER="false"
export DISABLE_CATCHUP_INDEXER="false"
export DISABLE_REALTIME_INDEXER="true"
# export DISABLE_EXCHANGE_RATES="true"
# export INDEXER_DISABLE_INTERNAL_TRANSACTIONS_FETCHER="true"
# export INDEXER_TX_ACTIONS_ENABLE="true"

# Shards
# Cyprus 1
export SUBNETWORK="cyprus1"
export ETHEREUM_JSONRPC_HTTP_URL=http://rpc.sandbox.quai.network:9200
export ETHEREUM_JSONRPC_TRACE_URL=http://rpc.sandbox.quai.network:9200
export ETHEREUM_JSONRPC_FALLBACK_TRACE_URL=http://rpc.sandbox.quai.network:9200

# Cyprus 2
# export SUBNETWORK="cyprus2"
# export ETHEREUM_JSONRPC_HTTP_URL=http://rpc.sandbox.quai.network/cyprus2
# export ETHEREUM_JSONRPC_TRACE_URL=http://rpc.sandbox.quai.network/cyprus2
# export ETHEREUM_JSONRPC_FALLBACK_TRACE_URL=http://rpc.sandbox.quai.network/cyprus2


# Micro services
# export MICROSERVICE_SC_VERIFIER_ENABLED="true"
# export MICROSERVICE_SC_VERIFIER_URL=https://scv.bs-quai.protofire.io
# export MICROSERVICE_SC_VERIFIER_ENABLED=true
# export MICROSERVICE_SC_VERIFIER_URL=http://localhost:8082/
# export MICROSERVICE_VISUALIZE_SOL2UML_ENABLED=true
# export MICROSERVICE_VISUALIZE_SOL2UML_URL=http://localhost:8081/
# export MICROSERVICE_SIG_PROVIDER_ENABLED=true
# export MICROSERVICE_SIG_PROVIDER_URL=http://localhost:8083/
# export MICROSERVICE_SC_VERIFIER_ENABLED=true
# export MICROSERVICE_SC_VERIFIER_URL=https://eth-bytecode-db.services.blockscout.com/
# export MICROSERVICE_SC_VERIFIER_TYPE=eth_bytecode_db

# Start Blockscout
# mix do deps.compile, compile && \
# mix compile && \

mix ecto.drop && \
mix ecto.create && \
# mix ecto.gen.migration name
# mix ecto.rollback && \
mix ecto.migrate && \

mix phx.server

# Start specific application only
# iex -S mix run --no-start --no-halt -e "Enum.each([:indexer], fn app -> {:ok, _} = Application.ensure_all_started(app) end)"
