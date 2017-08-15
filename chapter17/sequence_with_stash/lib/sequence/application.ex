defmodule Sequence.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    result = {:ok, pid} = Supervisor.start_link([], strategy: :one_for_one)
    start_workers(pid, 0)
    result
  end

  def start_workers(pid, inital_number) do
    {:ok, pid_stash} = Supervisor.start_child(pid, Sequence.Stash.child_spec(inital_number))
    Supervisor.start_child(pid, Sequence.SubSupervisor.child_spec(pid_stash))
  end
end
