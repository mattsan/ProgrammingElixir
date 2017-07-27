defmodule RingTicker do
  @interval 1_000

  def start(name) do
    pid = spawn(__MODULE__, :ticker, [name, name, 1])
    :global.register_name(name, pid)

    send pid, {:tick}
  end

  def start(name, prev_name) do
    pid = spawn(__MODULE__, :ticker, [name, name, 1])
    :global.register_name(name, pid)

    prev_node = :global.whereis_name(prev_name)
    send prev_node, {:register, name}
  end

  def ticker(name, next_name, node_count) do
    next_node = :global.whereis_name(next_name)
    receive do
      {:register, new_next_name} ->
        IO.puts "registering next node #{new_next_name}"

        new_next_node = :global.whereis_name(new_next_name)
        new_node_count = node_count + 1
        send new_next_node, {:change, next_name, new_node_count}
        ticker(name, new_next_name, new_node_count)

      {:change, new_next_name, new_node_count} ->
        IO.puts "new next node is #{new_next_name}, count #{new_node_count}"

        ticker(name, new_next_name, new_node_count)

      {:tick} ->
        IO.puts "start tick"

        send self(), {:tick, name, node_count}
        ticker(name, name, node_count)

      {:tick, prev_name, count} ->
        IO.puts "#{prev_name} ticked #{name}, #{name} is ticking #{next_name}, node count #{count}"

        :timer.sleep(@interval)

        next_node = :global.whereis_name(next_name)
        send next_node, {:tick, name, count}
        ticker(name, next_name, count)
    after
      @interval * node_count * 2 ->
        IO.puts "timeout"
    end
  end
end
