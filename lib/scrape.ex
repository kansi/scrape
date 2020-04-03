defmodule Scrape do
  import Ecto.Query
  alias Scrape.Emission
  alias Scrape.NationalGrid
  alias Scrape.Repo

  def get_date_for_data_download() do
    from(e in Emission,
      order_by: [desc: e.timestamp],
      limit: 1
    )
    |> Repo.one()
    |> case do
      nil ->
        {:ok, yesterday()}

      %Emission{timestamp: timestamp} ->
        calculate_next_date(timestamp)
    end
  end

  defp calculate_next_date(timestamp) do
    latest_fetch_date = Timex.to_date(timestamp)

    if Date.diff(yesterday(), latest_fetch_date) > 0 do
      {:ok, latest_fetch_date |> Date.add(1)}
    else
      {:error, nil}
    end
  end

  def download_and_store(date) do
    with {:ok, emission_data} <- NationalGrid.download_emission(date) do
      emission_data
      |> Enum.reduce(Ecto.Multi.new(), &store_data/2)
      |> Repo.transaction()
    end
  end

  defp store_data(
         %{
           "from" => from,
           "intensity" => %{"forecast" => forecast, "actual" => actual}
         },
         multi
       ) do
    changeset = Emission.changeset(from |> Timex.parse!("{ISO:Extended}"), forecast, actual)
    Ecto.Multi.insert(multi, from, changeset)
  end

  defp yesterday(), do: Date.add(Date.utc_today(), -1)
end
