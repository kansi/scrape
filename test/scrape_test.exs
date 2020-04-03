defmodule ScrapeTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  use Scrape.RepoCase
  alias Scrape.Emission

  describe "get_date_for_data_download/0" do
    test "returns yesterday if the database is empty" do
      {:ok, date} = Scrape.get_date_for_data_download()

      assert date == yesterday()
    end

    test "returns next day from lastest timestamp if the next day is less than yesterday" do
      insert(:emission, timestamp: now() |> Timex.shift(days: -2))

      {:ok, date} = Scrape.get_date_for_data_download()
      assert date == yesterday()
    end

    test "return {:error, nil} when there is not date left to download data for" do
      insert(:emission, timestamp: now() |> Timex.shift(days: -1))

      assert {:error, nil} == Scrape.get_date_for_data_download()
    end
  end

  describe "download_and_store/1" do
    setup do
      ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
      :ok
    end

    test "downloads and store data" do
      assert [] == Repo.all(Emission)

      use_cassette "get_emission_data" do
        Scrape.download_and_store(~D[2020-04-01])
      end

      refute [] == Repo.all(Emission)
    end
  end

  defp yesterday(), do: Date.add(Date.utc_today(), -1)

  defp now(), do: Timex.now()
end
