defmodule CallCount.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    gen_consumer_impl = CallCount.CallCountConsumer
    consumer_group_name = "call_counts"
    topic_names = ["call_counts"]

    children = [
      # Start the Ecto repository
      CallCount.Repo,
      # Start the Telemetry supervisor
      CallCountWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CallCount.PubSub},
      # Start the Endpoint (http/https)
      CallCountWeb.Endpoint,
      # Start a worker by calling: CallCount.Worker.start_link(arg)
      # {CallCount.Worker, arg}
      supervisor(
        KafkaEx.ConsumerGroup,
        [gen_consumer_impl, consumer_group_name, topic_names, consumer_group_opts]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CallCount.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CallCountWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
