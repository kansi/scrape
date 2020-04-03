defmodule Scrape.Application do
  use Application

  def start(_type, _args) do
    children = [
      Scrape.Repo
    ]

    children =
      case Application.get_env(:scrape, :disable_worker) do
        true ->
          children

        _ ->
          children ++ [Scrape.Worker]
      end

    opts = [strategy: :one_for_one, name: Scrape.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
