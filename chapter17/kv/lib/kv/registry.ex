defmodule KV.Registry do
  use GenServer

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def register(key, value) do
    GenServer.cast(__MODULE__, {:register, key, value})
  end

  def lookup(key) do
    GenServer.call(__MODULE__, {:lookup, key})
  end

  def init(stash_pid) do
    dictionary = KV.Stash.load(stash_pid)
    {:ok, {stash_pid, dictionary}}
  end

  def terminate(_reason, {stash_pid, dictionary}) do
    KV.Stash.store(stash_pid, dictionary)
  end

  def handle_cast({:register, key, value}, {stash_pid, dictionary}) do
    {:noreply, {stash_pid, Map.put(dictionary, key, value)}}
  end

  def handle_call({:lookup, key}, _from, {stash_pid, dictionary}) do
    {:reply, Map.get(dictionary, key), {stash_pid, dictionary}}
  end
end
