# Scrape

Scrapes data from [NationalGrid](https://carbon-intensity.github.io/api-definitions/#get-intensity-from-to)


## Compile

```elixir
$ mix deps.get
$ mix compile
```

## Setup database

```elixir
$ docker-compose up -d
$ mix ecto.create
$ mix ecto.migrate
```

## Test

```elixir
$ mix test
```

## Run

```elixir
$ iex -S mix
```
