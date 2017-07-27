defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, [value|values]) do
    {:reply, value, values}
  end

  def handle_cast({:push, value}, values) do
    {:noreply, [value|values]}
  end
end
