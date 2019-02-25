defmodule SnekizeTest do
  use ExUnit.Case, async: true
  doctest Snekize

  defstruct test_foo: "foo",
            test_bar: "bar",
            test_baz: "baz"

  describe "snake/1" do
    test "works with an Ecto.DateTime struct" do
      now = %{__struct__: Ecto.DateTime, right_now: "right now!"}
      assert Snekize.snake(now) == now
    end

    test "works with a list of structs" do
      assert Snekize.snake([%__MODULE__{}]) == [
               %{"test_foo" => "foo", "test_bar" => "bar", "test_baz" => "baz"}
             ]
    end

    test "works with a struct" do
      assert Snekize.snake(%__MODULE__{}) == %{
               "test_foo" => "foo",
               "test_bar" => "bar",
               "test_baz" => "baz"
             }
    end

    test "works with a list of primitives" do
      primitives = [1, "foo", 4.3, :cool_atom]
      assert Snekize.snake(primitives) == primitives
    end
  end
end
