defmodule Stack.Server do
  use GenServer

  def start_link(init \\ []) do
    GenServer.start_link(__MODULE__, init, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def handle_call(:pop, _from, [value|values]) do
    {:reply, value, values}
  end

  def handle_cast({:push, value}, values) do
    {:noreply, [value|values]}
  end
end
