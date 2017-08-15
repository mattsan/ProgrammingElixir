defmodule Stack.Server do
  use GenServer

  def start_link(initial_list) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, initial_list, name: __MODULE__)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def handle_call(:pop, _from, [value|rest]) do
    {:reply, value, rest}
  end

  def handle_cast({:push, value}, list) do
    {:noreply, [value|list]}
  end
end
