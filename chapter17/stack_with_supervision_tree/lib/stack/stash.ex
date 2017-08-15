defmodule Stack.Stash do
  use GenServer

  def start_link(initial_list) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, initial_list)
  end

  def save_value(pid, value) do
    GenServer.cast(pid, {:save_value, value})
  end

  def get_value(pid) do
    GenServer.call(pid, :get_value)
  end

  def handle_call(:get_value, _from, list) do
    {:reply, list, list}
  end

  def handle_cast({:save_value, new_list}, _list) do
    {:noreply, new_list}
  end
end
