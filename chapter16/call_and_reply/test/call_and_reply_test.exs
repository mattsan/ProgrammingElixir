defmodule CallAndReplyTest do
  use ExUnit.Case
  doctest CallAndReply

  test "greets the world" do
    assert CallAndReply.hello() == :world
  end
end
