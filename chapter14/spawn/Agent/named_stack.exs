# usage:
#
# $ iex
# iex(1)> c "named_stack.exs"
# [NamedStack]
# iex(2)> NamedStack.start_link()
# {:ok, #PID<0.88.0>}
# iex(3)> NamedStack.push(1)
# :ok
# iex(4)> NamedStack.push(2)
# :ok
# iex(5)> NamedStack.push(3)
# :ok
# iex(6)> NamedStack.get_list()
# [3, 2, 1]
# iex(7)> NamedStack.pop()
# 3
# iex(8)> NamedStack.get_list()
# [2, 1]
# iex(9)> NamedStack.start_link()
# {:error, {:already_started, #PID<0.88.0>}}

defmodule NamedStack do
  def start_link(list \\ []) do
    Agent.start_link(fn -> list end, name: __MODULE__)
  end

  def stop do
    Agent.stop(__MODULE__)
  end

  def push(value) do
    Agent.update(__MODULE__, &([value|&1]))
  end

  def get_list do
    Agent.get(__MODULE__, &(&1))
  end

  def get_top do
    Agent.get(__MODULE__, fn [value|_] -> value; [] -> nil end)
  end

  def pop do
    Agent.get_and_update(__MODULE__, fn [value|values] -> {value, values}; [] -> {nil, []} end)
  end
end
