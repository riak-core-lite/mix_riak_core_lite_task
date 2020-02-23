defmodule <%= module_name %> do
  use Application
  require Logger

  def start(_type, _args) do
    case <%= module_name %>.Supervisor.start_link() do
      {:ok, pid} ->
        :ok = :riak_core.register(vnode_module: <%= module_name %>.VNode)
        :ok = :riak_core_node_watcher.service_up(<%= module_name %>.Service, self())
        {:ok, pid}

      {:error, reason} ->
        Logger.error("Unable to start <%= module_name %> supervisor because: #{inspect(reason)}")
    end
  end
end

