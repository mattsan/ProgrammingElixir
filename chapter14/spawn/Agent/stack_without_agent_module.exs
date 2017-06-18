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
