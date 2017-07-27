defmodule Foo do
  def start do
    loop(0)
  end

  def loop(n) do
    receive do
    after
      n ->
        IO.puts "#{n} msec"
        if n < 1000, do: loop(n + 100)
    end
  end
end
