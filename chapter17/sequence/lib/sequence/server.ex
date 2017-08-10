defmodule Sequence.Server do
  use GenServer

  def start_link(init) do
    IO.puts("init: #{inspect(init)}")
    GenServer.start_link(__MODULE__, init, name: __MODULE__)
  end

  def next do
    GenServer.call(__MODULE__, :next)
  end

  def set(state) do
    GenServer.cast(__MODULE__, {:set, state})
  end

  def handle_call(:next, _from, state) do
    IO.puts("state: #{inspect state}")
    {:reply, state, state + 1}
  end

  def handle_cast({:set, new_state}, _old_state) do
    {:noreply, new_state}
  end
end
