defmodule Stack.Server do
  use GenServer

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def init(stash_pid) do
    initial_list = Stack.Stash.get_value(stash_pid)
    {:ok, {initial_list, stash_pid}}
  end

  def terminate(_reason, {initial_list, stash_pid}) do
    Stack.Stash.save_value(stash_pid, initial_list)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def handle_call(:pop, _from, {[value|rest], stash_pid}) do
    {:reply, value, {rest, stash_pid}}
  end

  def handle_cast({:push, value}, {list, stash_pid}) do
    {:noreply, {[value|list], stash_pid}}
  end
end
