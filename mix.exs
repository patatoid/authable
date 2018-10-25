defmodule Authable.Mixfile do
  use Mix.Project

  def project do
    [
      app: :authable,
      version: "0.9.2",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      description: description(),
      package: package(),
      deps: deps(),
      docs: [extras: ["README.md"]],
      dialyzer: [plt_add_deps: :transitive],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [
        :logger,
        :comeonin,
        :ecto,
        :postgrex,
        :secure_random,
        :plug
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:postgrex, "~> 0.13.5"},
      {:ecto, "~> 2.2.10"},
      {:comeonin, ">= 3.0.0"},
      {:bcrypt_elixir, ">= 1.1.1"},
      {:secure_random, ">= 0.5.1"},
      {:plug, ">= 1.0.0"},
      {:poison, ">= 2.0.0"},
      {:ex_machina, ">= 2.2.0", only: :test},
      {:credo, ">= 0.10.2", only: [:dev, :test]},
      {:ex_doc, ">= 0.19.1", only: :dev},
      {:dialyxir, ">= 0.5.1", only: [:dev], runtime: false},
      {:excoveralls, ">= 0.10.1", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: [
        "ecto.drop -r Authable.Repo --quiet",
        "ecto.create -r Authable.Repo --quiet",
        "ecto.migrate -r Authable.Repo --quiet",
        "test"
      ]
    ]
  end

  defp description do
    """
    OAuth2 Provider implementation modules and helpers using `ecto` and
    `postgress` for any `elixir` application.
    """
  end

  defp package do
    [
      name: :authable,
      files: ["lib", "priv", "mix.exs", "README.md"],
      maintainers: ["Mustafa Turan"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mustafaturan/authable"}
    ]
  end
end
