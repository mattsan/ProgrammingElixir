defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, sv_pid} = Supervisor.start_link(__MODULE__, nil)
    start_workers(sv_pid, initial_number)
    result
  end

  def init(_) do
    Supervisor.init([], strategy: :one_for_one)
  end

  def start_workers(sv_pid, initial_number) do
    {:ok, stash_pid} = Supervisor.start_child(sv_pid, Sequence.Stash.child_spec(initial_number))
    Supervisor.start_child(sv_pid, Sequence.SubSupervisor.child_spec(stash_pid))
  end
end
