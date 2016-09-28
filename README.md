# Carmelize
> Gooey chewy library to camelize keys in a map

<center>
<img src="http://i.imgur.com/LPIHMQA.gif" alt="The soft, warm, cinnamon pretzels are your map, and the decadent caramel is this library" height="400">
</center>

#### An Elixir library for converting the keys of snake_case maps to camelCase

Works when any child is a list, struct, or any other primitive type. Gracefully ignores DateTime structs.

## Installation
1. Add carmelize to your list of dependencies in mix.exs:
```elixir
def deps do
  [{:carmelize, "~> 0.1.0"}]
end
```
2. Ensure carmelize is started before your application:
``` elixir
def application do
  [applications: [:carmelize]]
end
```

## Usage

Simply pass any map into the `Carmelize.camelize()` function, and it will return a map with all keys converted to camelCase.


## Example

```elixir
awesome_map = %{test_foo: "foo",
                test_bar: %CoolStruct{cool_key: "Cool Value"},
                test_baz: ["baz", "boz", "box"],
                test_boz: %{awesome_lib: "Thanks man!"}
              }

awesomer_map = Carmelize.camelize(awesome_map)

```


*Output:*

```elixir
awesomer_map = %{"testFoo" => "foo",
                "testBar" => %CoolStruct{"coolKey" => "Cool Value"},
                "testBaz" => ["baz", "boz", "box"],
                "testBoz" => %{"awesomeLib" => "Thanks man!"}
              }
```

## Contributing

Pull requests welcome! Add tests to the `carmelize_test.exs` and ensure all tests are passing before PR submission.