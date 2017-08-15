defmodule Stack.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    result = {:ok, pid} = Supervisor.start_link([], opts)

    {:ok, stash} = Supervisor.start_child(pid, Stack.Stash.child_spec([1,2,3]))
    Supervisor.start_child(pid, Stack.Server.child_spec(stash))

    result
  end
end
