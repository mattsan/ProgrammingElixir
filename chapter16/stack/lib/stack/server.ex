defmodule Stack.Server do
  use GenServer

  def handle_call({:push, value}, _from, values) do
    {:reply, :ok, [value|values]}
  end

  def handle_call(:pop, _from, [value|values]) do
    {:reply, value, values}
  end
end
