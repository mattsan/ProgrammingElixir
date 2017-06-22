# usage:
#
# $ iex
# iex(1)> c "stack.exs"
# [Stack]
# iex(2)> {:ok, stack} = Stack.start_link()
# {:ok, #PID<0.88.0>}
# iex(3)> Stack.push(stack, 1)
# :ok
# iex(4)> Stack.push(stack, 2)
# :ok
# iex(5)> Stack.push(stack, 3)
# :ok
# iex(6)> Stack.get_list(stack)
# [3, 2, 1]
# iex(7)> Stack.pop(stack)
# 3
# iex(8)> Stack.get_list(stack)
# [2, 1]

defmodule Stack do
  def start_link(list \\ []) do
    Agent.start_link(fn -> list end)
  end

  def stop(stack) do
    Agent.stop(stack)
  end

  def push(stack, value) do
    Agent.update(stack, &([value|&1]))
  end

  def get_list(stack) do
    Agent.get(stack, &(&1))
  end

  def get_top(stack) do
    Agent.get(stack, fn [value|_] -> value; [] -> nil end)
  end

  def pop(stack) do
    Agent.get_and_update(stack, fn [value|values] -> {value, values}; [] -> {nil, []} end)
  end
end
