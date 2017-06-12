defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self(), fn (_, send_to) -> spawn(Chain, :counter, [send_to]) end

    send last, 0

    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

#        10  0.002861
#       100  0.003399
#     1,000  0.010565
#    10,000  0.096230
#   100,000  0.881809
# 1,000,000  9.155776
