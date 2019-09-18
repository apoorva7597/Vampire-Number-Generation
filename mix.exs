defmodule Vampcounter.MixProject do
  use Mix.Project

  def project do
    [
      app: :vampcounter,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      elixirc_path: elixirc_paths(Mix.env),
      escript: escript(),
      deps: deps()
    ]
  end

  def escript do
    [main_module: Vampcounter.Application]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger,],
      mod: {Vampcounter.Application, [0,0]}

    ]
  end
  defp elixirc_paths(_), do: ["lib", "web"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 0.11"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
