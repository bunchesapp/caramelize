defmodule CaramelizeTest do
  use ExUnit.Case, async: true

  defstruct test_foo: "foo",
    test_bar: "bar",
    test_baz: "baz"

  describe "camelize/1" do
    test "works with a string" do
      assert Caramelize.camelize("cool_string") == "coolString"
    end

    test "works with an atom" do
      assert Caramelize.camelize(:cool_string) == "coolString"
    end

    test "works with a flat map" do
      assert Caramelize.camelize(%{cool_atom: "foo"}) == %{"coolAtom" => "foo"}
      assert Caramelize.camelize(%{"cool_string" => "bar"}) == %{"coolString" => "bar"}
    end

    test "works with a nested map" do
      assert Caramelize.camelize(%{cool_atom: %{another_cool_atom: "foo"}}) ==
        %{"coolAtom" => %{"anotherCoolAtom" => "foo"}}
      assert Caramelize.camelize(%{"cool_string" => %{"another_cool_string" => "bar"}}) ==
        %{"coolString" => %{"anotherCoolString" => "bar"}}
    end

    test "works with a list" do
      assert Caramelize.camelize([%{cool_key: "foo"}]) == [%{"coolKey" => "foo"}]
    end

    test "works with a list of maps" do
        assert Caramelize.camelize(%{list_key: [%{foo: 12, bar: 13}]}) ==
                             %{"listKey" => [%{"foo" => 12, "bar" => 13}]}
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
