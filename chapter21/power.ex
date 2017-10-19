defmodule Power do
  defmacro lhs <> rhs do
    quote do: List.duplicate(unquote(lhs), unquote(rhs)) |> Enum.reduce(&*/2)
  end

  defmacro __using__(_) do
    IO.puts "__using__ が呼ばれた"
    quote do
      import Kernel, except: [<>: 2]
      import Power
    end
  end
end

defmodule Test do
  use Power

  IO.puts "Power が use された"

  def test1 do
    IO.puts 2 <> 8
  end

  def test2 do
    IO.puts 2 <> 2 <> 3
  end
end

IO.puts "Test が定義された"

Test.test1 # => 256
Test.test2 # => 256
