defmodule Scrape.Factory do
  use ExMachina.Ecto, repo: Scrape.Repo

  alias Scrape.Emission

  # pun intended
  def emission_factory do
    %Emission{
      timestamp: "2020-01-01T00:00Z",
      forecast: 242,
      actual: 242
    }
  end
end
