defmodule CallAndCast.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def sync do
    GenServer.call(__MODULE__, nil)
    IO.puts "息切れ"
  end

  def async do
    GenServer.cast(__MODULE__, nil)
    IO.puts "息切れ"
  end

  def handle_call(_msg, from, state) do
    IO.puts "同期"
    :timer.sleep(100)
    {:reply, :ok, state}
  end

  def handle_cast(_msg, state) do
    IO.puts "非同期"
    :timer.sleep(100)
    {:noreply, state}
  end
end
