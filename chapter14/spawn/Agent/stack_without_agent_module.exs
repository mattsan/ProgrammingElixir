# usage:
#
# $ iex
# iex(1)> c "stack_without_agent_module.exs"
# [StackWithoutAgentModule]
# iex(2)> stack = StackWithoutAgentModule.start_link()
# #PID<0.88.0>
# iex(3)> StackWithoutAgentModule.push(stack, 1)
# :ok
# iex(4)> StackWithoutAgentModule.push(stack, 2)
# :ok
# iex(5)> StackWithoutAgentModule.push(stack, 3)
# :ok
# iex(6)> StackWithoutAgentModule.get_list(stack)
# [3, 2, 1]
# iex(7)> StackWithoutAgentModule.pop(stack)
# 3
# iex(8)> StackWithoutAgentModule.get_list(stack)
# [2, 1]

defmodule StackWithoutAgentModule do
  def start_link(list \\ []) do
    spawn_link(__MODULE__, :loop, [list])
  end

  def stop(stack) do
    send stack, {self(), :stop}
    receive do
      {:ok, ^stack} -> :ok
      msg -> msg
    end
  end

  def push(stack, value) do
    send stack, {self(), :push, value}
    receive do
      {:ok, ^stack} -> :ok
      msg -> msg
    end
  end

  def get_list(stack) do
    send stack, {self(), :get_list}
    receive do
      {:ok, ^stack, list} -> list
      msg -> msg
    end
  end

  def get_top(stack) do
    send stack, {self(), :get_list}
    receive do
      {:ok, ^stack, value} -> value
      msg -> msg
    end
  end

  def pop(stack) do
    send stack, {self(), :pop}
    receive do
      {:ok, ^stack, value} -> value
      msg -> msg
    end
  end

  def loop(list) do
    receive do
      {sender, :push, value} ->
        send sender, {:ok, self()}
        loop([value|list])

      {sender, :pop} ->
        [value|values] = list
        send sender, {:ok, self(), value}
        loop(values)

      {sender, :get_list} ->
        send sender, {:ok, self(), list}
        loop(list)

      {sender, :get_top} ->
        [value|_] = list
        send sender, {:ok, self(), value}
        loop(list)

      {sender, :stop} ->
        send sender, {:ok, self()}
    end
  end
end
