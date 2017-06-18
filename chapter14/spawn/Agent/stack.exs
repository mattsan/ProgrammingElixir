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
