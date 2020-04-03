defmodule Scrape.Repo.Migrations.Emissions do
  use Ecto.Migration

  def change do
    create table("emissions") do
      add(:timestamp, :utc_datetime)
      add(:forecast, :integer)
      add(:actual, :integer)
    end
  end
end
