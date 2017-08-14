defmodule KV.Stash do
  use GenServer

  def start_link(initial_dictionary) do
    GenServer.start_link(__MODULE__, initial_dictionary)
  end

  def load(pid) do
    GenServer.call(pid, :load)
  end

  def store(pid, value) do
    GenServer.cast(pid, {:store, value})
  end

  def handle_call(:load, _from, dictionary) do
    {:reply, dictionary, dictionary}
  end

  def handle_cast({:store, dictionary}, _state) do
    {:noreply, dictionary}
  end
end
