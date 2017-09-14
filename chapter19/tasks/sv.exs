defmodule SV do
  use Task

  def start_link(denominator) do
    Task.start_link(__MODULE__, :run, [denominator])
  end

  def run(denominator) do
    IO.puts(inspect(1 / denominator))
  end
end

# {:ok, pid} = Supervisor.start_link([], strategy: :one_for_one)
#
# Supervisor.start_child(pid, SV.child_spec(1))
# Supervisor.start_child(pid, SV.child_spec(0))
# Supervisor.start_child(pid, SV.child_spec(-1))
