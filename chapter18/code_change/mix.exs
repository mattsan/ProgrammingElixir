defmodule CodeChange.Mixfile do
  use Mix.Project

  def project do
    [
      app: :code_change,
      version: "0.3.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CodeChange.Application, 123},
      registered: [CodeChange.Worker]
    ]
  end

  defp deps do
    [
      {:distillery, "~> 1.4", runtime: false}
    ]
  end
end
