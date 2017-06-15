defmodule WorkingWithMultipuleProcess3 do
  import :timer, only: [sleep: 1]

  def coprocess(parent) do
    send parent, {:ok, self(), "message from coprocess"}
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
    spawn_link(WorkingWithMultipuleProcess3, :coprocess, [self()])
    sleep 500
    receive_all_messages()
  end
end

WorkingWithMultipuleProcess3.run
