defmodule WorkingWithMultipleProcesses1 do
  def reflect do
    receive do
      {sender, token} ->
        send sender, {:ok, token}
        reflect
    end
  end
end

reflector1 = spawn(WorkingWithMultipleProcesses1, :reflect, [])
reflector2 = spawn(WorkingWithMultipleProcesses1, :reflect, [])

send reflector1, {self(), "fred"}
send reflector2, {self(), "betty"}

receive do
  {:ok, token} ->
    IO.puts token
end

receive do
  {:ok, token} ->
    IO.puts token
end
