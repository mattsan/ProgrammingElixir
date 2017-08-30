defmodule CodeChangeTest do
  use ExUnit.Case
  doctest CodeChange

  test "greets the world" do
    assert CodeChange.hello() == :world
  end
end
