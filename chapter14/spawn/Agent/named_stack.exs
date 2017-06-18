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
