defmodule Nym.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NymWeb.Telemetry,
      Nym.Repo,
      {DNSCluster, query: Application.get_env(:nym, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Nym.PubSub},

      NymWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Nym.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    NymWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
