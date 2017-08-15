defmodule Sequence.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    {:ok, pid} = Supervisor.start_link([], strategy: :one_for_one)
    {:ok, pid_stash} = Supervisor.start_child(pid, Sequence.Stash.child_spec(0))
    Supervisor.start_child(pid, Sequence.SubSupervisor.child_spec(pid_stash))
  end
end
