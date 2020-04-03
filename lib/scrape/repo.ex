defmodule Scrape.Repo do
  use Ecto.Repo, otp_app: :scrape, adapter: Ecto.Adapters.Postgres
end
