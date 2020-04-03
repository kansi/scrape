defmodule Scrape.NationalGrid do
  @service "https://api.carbonintensity.org.uk"

  def download_emission(date) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get(@service <> "/intensity/date/#{date}") do
      %{"data" => emission_data} = body |> Jason.decode!()
      {:ok, emission_data}
    else
      _error ->
        {:error, :download_failed}
    end
  end
end
