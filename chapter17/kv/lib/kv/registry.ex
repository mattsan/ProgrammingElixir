defmodule KV.Registry do
  use GenServer

  def start_link(init_state) do
    GenServer.start_link(__MODULE__, init_state, name: __MODULE__)
  end

  def register(key, value) do
    GenServer.cast(__MODULE__, {:register, key, value})
  end

  def lookup(key) do
    GenServer.call(__MODULE__, {:lookup, key})
  end

  def handle_cast({:register, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:lookup, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end
