defmodule AllCallbacksTest do
  use ExUnit.Case
  doctest AllCallbacks

  test "greets the world" do
    assert AllCallbacks.hello() == :world
  end
end
