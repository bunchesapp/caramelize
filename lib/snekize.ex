defmodule Snekize do
  @moduledoc """
  An Elixir library for converting the keys of camelCase maps to snake_case
  """

  @doc """
  Snakeizes a variety of data structures

  * atom -> Snakeizes the atom
  * string -> Snakeizes the string
  * nested map -> Snakeizes the nested map keys
  * list of maps -> Snakeizes the maps
  * map -> Snakeizes the keys
  * DateTime -> pass it straight through for easier serialization

  ## Examples

      iex(1)> Snekize.snake("coolString")
      "cool_string"

      iex(2)> Snekize.snake(:coolString)
      "cool_string"

      iex(3)> Snekize.snake(%{coolAtom: "foo"})
      %{"cool_atom" => "foo"}

      iex(4)> Snekize.snake(%{"coolString" => "bar"})
      %{"cool_string" => "bar"}

      iex(5)> Snekize.snake(%{coolAtom: %{anotherCoolAtom: "foo"}})
      %{"cool_atom" => %{"another_cool_atom" => "foo"}}

      iex(6)> Snekize.snake(%{"coolString" => %{
      ...>      "anotherCoolString" => "bar"}
      ...>    })
      %{"cool_string" => %{"another_cool_string" => "bar"}}

      iex(7)> Snekize.snake([%{coolKey: "foo"}])
      [%{"cool_key" => "foo"}]

      iex(8)> Snekize.snake(%{listKey: [%{foo: 12, bar: 13}]})
      %{"list_key" => [%{"bar" => 13, "foo" => 12}]}

      iex(9)> Snekize.snake(DateTime.from_unix!(1476219081))
      %DateTime{calendar: Calendar.ISO, day: 11, hour: 20, microsecond: {0, 0},
       minute: 51, month: 10, second: 21, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """

  # Snakeizes atoms in a map
  def snake(key) when is_atom(key) do
    key |> Atom.to_string() |> snake
  end

  # Snakeizes strings in a map
  def snake(key) when is_binary(key) do
    Recase.to_snake(key)
  end

  # if a nested map, snake the nested map keys
  def snake({key, value}) when is_map(value) or is_list(value) do
    {snake(key), snake(value)}
  end

  # if a list of maps, snake the maps
  def snake(map_list) when is_list(map_list) do
    Enum.map(map_list, fn
      %{__struct__: _} = map ->
        map
        |> Map.from_struct()
        |> snake

      map = %{} ->
        snake(map)

      any ->
        any
    end)
  end

  # if a map, snake the keys
  def snake({key, value}) do
    key = snake(key)
    {key, value}
  end

  def snake(%struct{} = datetime) when struct in [DateTime, Ecto.DateTime, NaiveDateTime] do
    datetime
  end

  # if a struct, convert to map and then snake
  def snake(%{__struct__: _} = map) do
    map
    |> Map.from_struct()
    |> snake
  end

  # base snake function
  def snake(%{} = map) do
    map
    |> Enum.map(&__MODULE__.snake/1)
    |> Map.new()
  end
end
