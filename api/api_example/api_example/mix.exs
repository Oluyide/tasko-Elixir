defmodule ApiExample.Mixfile do
  use Mix.Project

  def project do
    [
      app: :api_example,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: Coverex.Task],
      preferred_cli_env: ["white_bread.run": :test],


    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [

      mod: {ApiExample.Application, []},
      extra_applications: [:ex_machina ,:logger, :runtime_tools, :sms_blitz]
      #applications: [:google_maps]


    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:pbkdf2_elixir, "~> 0.12"},
      {:guardian, "~> 1.0"},
      {:plug_cowboy, "~> 1.0"},
      {:cors_plug, "~> 1.5"},
      {:coverex, "~> 1.4.10", only: :test},
      {:white_bread, "~> 4.3", only: [:test]},
      {:poison, "~> 3.1"},
      {:phoenix_swagger, "~> 0.6.2"},
      {:geo_postgis, "~> 2.1.0"},
      {:ex_machina, "~> 2.2"},
      {:hound, "~> 1.0"},
      {:google_maps, "~> 0.9"},
      {:fcmex, "~> 0.3.0"},
      {:sms_blitz, "~> 0.2.0"}

    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  # $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": [ "ecto.drop", "ecto.create --quiet", "ecto.migrate", "test"],
      "swagger": ["phx.swagger.generate priv/static/swagger.json --router DistanceTracker.Router --endpoint DistanceTracker.Endpoint"]
    ]
  end

end
