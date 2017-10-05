defmodule My do
  defmacro macro(name) do
    IO.inspect quote do: def unquote(name)(), do: unquote(name)
  end
end

defmodule Test do
  require My

  [:foo, :bar, :baz] |> Enum.each(fn name -> My.macro(name) end)
end

# {:def, [context: My, import: Kernel],
#  [{{:name, [line: 10], nil}, [context: My], []},
#   [do: {:name, [line: 10], nil}]]}
# warning: variable "name" is unused
#   m3.exs:10
#
# ** (CompileError) m3.exs:10: invalid syntax in def name()
#     (elixir) lib/enum.ex:675: Enum."-each/2-lists^foreach/1-0-"/2
#     (elixir) lib/enum.ex:675: Enum.each/2
#     m3.exs:10: (module)
