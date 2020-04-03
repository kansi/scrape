defmodule Scrape.Emission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emissions" do
    field(:timestamp, :utc_datetime)
    field(:forecast, :integer)
    field(:actual, :integer)
  end

  def changeset(timestamp, forecast, actual) do
    %__MODULE__{}
    |> change(%{
      timestamp: timestamp,
      forecast: forecast,
      actual: actual
    })
  end
end
