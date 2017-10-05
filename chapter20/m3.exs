defmodule My do
  defmacro mydef(name) do
    IO.inspect(quote do
      def unquote(name)(), do: unquote(name)
    end)
  end
end

defmodule Test do
  require My

  [:foo, :bar, :baz] |> Enum.each(fn name -> My.mydef(name) end)
end

# {:def, [context: My, import: Kernel],
#  [{{:name, [line: 12], nil}, [context: My], []},
#   [do: {:name, [line: 12], nil}]]}
# warning: variable "name" is unused
#   m3.exs:12
#
# ** (CompileError) m3.exs:12: invalid syntax in def name()
#     (elixir) lib/enum.ex:675: Enum."-each/2-lists^foreach/1-0-"/2
#     (elixir) lib/enum.ex:675: Enum.each/2
#     m3.exs:12: (module)
