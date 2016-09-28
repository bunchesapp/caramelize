defmodule Carmelize.Mixfile do
  use Mix.Project

  def project do
    [app: :carmelize,
     version: "0.1.0",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    An Elixir library that converts maps from `snake_case` to `camelCase`.
    """
  end

  defp deps do
    [{:ex_doc, github: "elixir-lang/ex_doc"}]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["James Rasmussen", "Jake Hasler"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/SRVentures/carmelize",
        "Docs" => "https://github.com/SRVentures/carmelize"
      }
    ]
  end

end
