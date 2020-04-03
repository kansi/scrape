defmodule Scrape.Worker do
  @moduledoc """
  Polls NationalGrid for the emissions data for the previous day.

  NOTE: When service start for the first time i.e. the database is emtpy
  it starts fetching emission data from the previous day
  """

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(_args) do
    {:ok, %{}, 0}
  end

  @impl true
  def handle_info(:timeout, state) do
    with {:ok, date} <- Scrape.get_date_for_data_download() do
      Scrape.download_and_store(date)
    end

    {:noreply, state, 3600_000}
  end
end
