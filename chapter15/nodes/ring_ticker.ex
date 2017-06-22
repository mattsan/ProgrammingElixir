defmodule RingTicker do
  @interval 1_000

  def start(name) do
    pid = spawn(__MODULE__, :ticker, [name, name])
    :global.register_name(name, pid)

    send pid, {:tick}
  end

  def start(name, prev_name) do
    pid = spawn(__MODULE__, :ticker, [name, name])
    :global.register_name(name, pid)

    prev_node = :global.whereis_name(prev_name)
    send prev_node, {:register, name}
  end

  def ticker(name, next_name) do
    next_node = :global.whereis_name(next_name)
    receive do
      {:register, new_next_name} ->
        IO.puts "registering next node #{new_next_name}"

        new_next_node = :global.whereis_name(new_next_name)
        send new_next_node, {:change, next_name}
        ticker(name, new_next_name)

      {:change, new_next_name} ->
        IO.puts "new next node is #{new_next_name}"

        ticker(name, new_next_name)

      {:tick} ->
        IO.puts "start tick"

        send self(), {:tick, name}
        ticker(name, name)

      {:tick, prev_name} ->
        IO.puts "#{prev_name} ticked #{name}, #{name} is ticking #{next_name}"

        :timer.sleep(@interval)

        next_node = :global.whereis_name(next_name)
        send next_node, {:tick, name}
        ticker(name, next_name)
    after
      @interval * 5 ->
        IO.puts "timeout"
    end
  end
end
