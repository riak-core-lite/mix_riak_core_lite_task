defmodule Rcl.MixProject do
  use Mix.Project

  def project do
    [
      app: :rcl,
      version: "0.1.6",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    Mix task to setup a Riak Core Lite project 
    """
  end

  defp package() do
    [
      maintainers: ["Mariano Guerra"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/riak-core-lite/mix_riak_core_lite_task"},
      files: ["lib", "mix.exs", "README.md", ".formatter.exs", "templates"]
    ]
  end
end
