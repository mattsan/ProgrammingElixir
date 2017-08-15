defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [])
    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    {:ok, stash} = Supervisor.start_child(sup, Sequence.Stash.child_spec(initial_number))
    Supervisor.start_child(sup, Sequence.SubSupervisor.child_spec(stash))
  end

  def init(_) do
    Supervisor.init([], strategy: :one_for_one)
  end
end
