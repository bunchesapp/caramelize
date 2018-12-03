defmodule CaramelizeTest do
  use ExUnit.Case, async: true
  doctest Caramelize

  defstruct test_foo: "foo",
    test_bar: "bar",
    test_baz: "baz"

  describe "camelize/1" do
    test "works with a DateTime struct" do
      now = %{__struct__: DateTime, right_now: "right now!"}
      assert Caramelize.camelize(now) == now
    end

    test "works with a list of structs" do
      assert Caramelize.camelize([%__MODULE__{}]) == [%{"testFoo" => "foo",
                                                  "testBar" => "bar",
                                                  "testBaz" => "baz"}]
    end

    test "works with a struct" do
      assert Caramelize.camelize(%__MODULE__{}) == %{"testFoo" => "foo",
                                                  "testBar" => "bar",
                                                  "testBaz" => "baz"}
    end

    test "works with a list of primitives" do
      primitives = [1, "foo", 4.3, :cool_atom]
      assert Caramelize.camelize(primitives) == primitives
    end
  end
end
