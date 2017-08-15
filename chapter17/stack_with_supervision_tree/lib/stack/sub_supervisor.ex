defmodule Stack.SubSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, stash_pid)
  end

  def init(stash_pid) do
    Supervisor.init([{Stack.Server, stash_pid}], strategy: :one_for_one)
  end
end
