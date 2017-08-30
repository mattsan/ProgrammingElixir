defmodule Sequence.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.3.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Sequence.Application, []},
      env: [initial_number: 456],
      registered: [Sequence.Server]
    ]
  end

  defp deps do
    [
      {:distillery, "~> 1.4", runtime: false}
    ]
  end
end
