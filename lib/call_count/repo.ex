defmodule CallCount.Repo do
  use Ecto.Repo,
    otp_app: :call_count,
    adapter: Ecto.Adapters.Postgres
end
