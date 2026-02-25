defmodule Nym.Repo do
  use Ecto.Repo,
    otp_app: :nym,
    adapter: Ecto.Adapters.Postgres
end
