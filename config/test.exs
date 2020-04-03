use Mix.Config

config :scrape, Scrape.Repo,
  database: "emission",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
