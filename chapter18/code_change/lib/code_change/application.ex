defmodule CodeChange.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    children = [
      {CodeChange.Worker, args},
    ]

    opts = [strategy: :one_for_one, name: CodeChange.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
