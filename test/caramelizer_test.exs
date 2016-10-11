defmodule CaramelizeTest do
  use ExUnit.Case, async: true
  doctest Caramelize

  defstruct test_foo: "foo",
    test_bar: "bar",
    test_baz: "baz"

  describe "camelize/1" do


    test "works with an Ecto.DateTime struct" do
      {:ok, now} = Ecto.DateTime.cast("2016-05-21 12:12:12")
      assert Caramelize.camelize(now) == now
    end

    test "works with a list of structs" do
      assert Caramelize.camelize([%__MODULE__{}]) == [%{"testFoo" => "foo",
                                                  "testBar" => "bar",
                                                  "testBaz" => "baz"}]
    end

    test "works with a list of primitives" do
      primitives = [1, "foo", 4.3, :cool_atom]
      assert Caramelize.camelize(primitives) == primitives
    end
  end

end
