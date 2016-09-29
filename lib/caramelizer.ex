defmodule Caramelize do
  @moduledoc """
  An Elixir library for converting the keys of snake_case maps to camelCase
  """

  # Camelize atoms in a map
  def camelize(key) when is_atom(key) do
    key |> Atom.to_string |> camelize
  end

  # Camelize strings in a map
  def camelize(key) when is_binary(key) do
    capitalized = Macro.camelize(key)
    <<first>> <> rest = capitalized
    String.downcase(<<first>>) <> rest
  end

  # if a nested map, camelize the nested map keys
  def camelize({key, value}) when is_map(value) or is_list(value) do
    {camelize(key), camelize(value)}
  end

  # if a list of maps, camelize the maps
  def camelize(map_list) when is_list(map_list) do
    Enum.map(map_list, fn
      (%{__struct__: _} = map) ->
        map
        |> Map.from_struct
        |> camelize
      (map = %{}) -> camelize(map)
      any -> any
    end)
  end

  # if a map, camelize the keys
  def camelize({key, value}) do
    key = camelize(key)
    {key, value}
  end

  # if a DateTime struct, just pass it along and
  # let phoenix handle the serialization
  def camelize(%DateTime{} = date_time) do
    date_time
  end

  # if a DateTime struct, just pass it along and
  # let phoenix handle the serialization
  def camelize(%Ecto.DateTime{} = date_time) do
    date_time
  end

  # base camelize function
  def camelize(%{} = map) do
    map
    |> Enum.map(&__MODULE__.camelize/1)
    |> Map.new
  end
end
