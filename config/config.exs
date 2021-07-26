# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :call_count,
  ecto_repos: [CallCount.Repo]

# Configures the endpoint
config :call_count, CallCountWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vs5NXnwRXwuhr15lEDaaBCOEZZlSqrUqC5qzxrKuZ9VXtj16J56MMs6tr4aB0DNw",
  render_errors: [view: CallCountWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub: [name: MyApp.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "XChBdhD0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :kafka_ex,
  brokers: [
    {"localhost", 19092}
  ],
  disable_default_worker: true,
  # Timeout value, in msec, for synchronous operations (e.g., network calls).
  # If this value is greater than GenServer's default timeout of 5000, it will also
  # be used as the timeout for work dispatched via KafkaEx.Server.call (e.g., KafkaEx.metadata).
  # In those cases, it should be considered a 'total timeout', encompassing both network calls and
  # wait time for the genservers.
  sync_timeout: 3000,
  # Supervision max_restarts - the maximum amount of restarts allowed in a time frame
  max_restarts: 10,
  # Supervision max_seconds -  the time frame in which :max_restarts applies
  max_seconds: 60,
  # Interval in milliseconds that GenConsumer waits to commit offsets.
  commit_interval: 5_000,
  # Threshold number of messages consumed for GenConsumer to commit offsets
  # to the broker.
  commit_threshold: 100,
  # This is the flag that enables use of ssl
  use_ssl: false,
  # see SSL OPTION DESCRIPTIONS - CLIENT SIDE at http://erlang.org/doc/man/ssl.html
  # for supported options
  # ssl_options: [
  #   cacertfile: File.cwd!() <> "/ssl/ca-cert",
  #   certfile: File.cwd!() <> "/ssl/cert.pem",
  #   keyfile: File.cwd!() <> "/ssl/key.pem"
  # ],
  # Interval in milliseconds to wait before reconnect to kafka
  sleep_for_reconnect: 400,
  kafka_version: "kayrock"
