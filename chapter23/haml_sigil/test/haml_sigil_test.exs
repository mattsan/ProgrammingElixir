defmodule HamlSigilTest do
  use ExUnit.Case
  doctest HamlSigil

  test "greets the world" do
    assert HamlSigil.hello() == :world
  end
end
