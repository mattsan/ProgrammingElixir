defmodule CallAndReply.Server do
  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def call_and_no_reply, do: GenServer.call(__MODULE__, :call_and_no_reply)

  def call_and_reply, do: GenServer.call(__MODULE__, :call_and_reply)

  def handle_call(:call_and_no_reply, _from, state) do
    {:noreply, state}
  end

  def handle_call(:call_and_reply, from, state) do
    spawn(fn ->
      IO.puts "sleep 1 sec"
      :timer.sleep 1000
      GenServer.reply(from, :ok)
    end)
    {:noreply, state}
  end
end
