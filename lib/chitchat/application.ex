defmodule Chitchat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChitchatWeb.Telemetry,
      # Start the Ecto repository
      Chitchat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chitchat.PubSub},
      # Start Finch
      {Finch, name: Chitchat.Finch},
      # Start the Endpoint (http/https)
      ChitchatWeb.Endpoint
      # Start a worker by calling: Chitchat.Worker.start_link(arg)
      # {Chitchat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chitchat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChitchatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
