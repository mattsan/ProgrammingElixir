defmodule KV.Supervisor do
  use Supervisor

  def start_link(initial_dictionary) do
    {:ok, pid_supervisor} = Supervisor.start_link(__MODULE__, [])

    {:ok, pid_stash} = Supervisor.start_child(pid_supervisor, KV.Stash.child_spec(initial_dictionary))
    Supervisor.start_child(pid_supervisor, KV.Registry.child_spec(pid_stash))
  end

  def init(_args) do
    Supervisor.init([], strategy: :one_for_one)
  end
end
