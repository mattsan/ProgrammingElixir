defmodule Sequence.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    initial_number = Application.get_env(:sequence, :initial_number)
    children = [
      {Sequence.Supervisor, initial_number}
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
