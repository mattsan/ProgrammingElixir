defmodule WorkingWithMultipuleProcess4 do
  import :timer, only: [sleep: 1]

  def coprocess(parent) do
    send parent, {:ok, self(), "message from coprocess"}
    raise :exception
  end

  def receive_all_messages do
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        receive_all_messages()
    after 500 ->
      IO.puts "Nothing happened"
    end
  end

  def run do
    spawn_monitor(WorkingWithMultipuleProcess4, :coprocess, [self()])
    sleep 500
    receive_all_messages()
  end
end

WorkingWithMultipuleProcess4.run
