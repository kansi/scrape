defmodule Scrape.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Scrape.Repo

      import Ecto
      import Ecto.Query
      import Scrape.RepoCase
      import Scrape.Factory
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Scrape.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Scrape.Repo, {:shared, self()})
    end

    :ok
  end
end
