defmodule Scrape.WorkerTest do
  use ExUnit.Case
  use Scrape.RepoCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Scrape.Worker
  alias Scrape.Emission

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "init/1 returns with a timeout 0" do
    assert {:ok, %{}, 0} == Worker.init(:ignore)
  end

  test "handle_info/2 returns with a timeout 3600 seconds" do
    assert [] == Repo.all(Emission)

    use_cassette "get_emission_data" do
      assert {:noreply, %{}, 3600_000} == Worker.handle_info(:timeout, %{})
    end

    refute [] == Repo.all(Emission)
  end
end
