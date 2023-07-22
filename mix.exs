defmodule RetryOnStale.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :retry_on_stale,
      elixir: "~> 1.9",
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),

      # Hex
      version: @version,
      package: package(),
      description: "Elixir utility for retrying stale Ecto entry operations",

      # ExDoc
      name: "RetryOnStale",
      source_url: "https://github.com/mathieuprog/retry_on_stale",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.10"},
      {:decimal, "~> 2.1"},
      {:ecto_sql, "~> 3.10", only: :test},
      {:postgrex, "~> 0.17", only: :test},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:dialyxir, "~> 1.3", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      test: [
        "ecto.create --quiet",
        "ecto.rollback --all",
        "ecto.migrate",
        "test"
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      licenses: ["Apache-2.0"],
      maintainers: ["Mathieu Decaffmeyer"],
      links: %{
        "GitHub" => "https://github.com/mathieuprog/retry_on_stale",
        "Sponsor" => "https://github.com/sponsors/mathieuprog"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}"
    ]
  end
end
