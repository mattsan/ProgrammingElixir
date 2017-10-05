defmodule My do
  defmacro mydef(name) do
    IO.inspect(quote do
      def unquote(name)(), do: unquote(name)
    end)
  end
end

defmodule Test do
  require My

  [:foo, :bar, :baz] |> Enum.each(&My.mydef(&1))
end

# {:def, [context: My, import: Kernel],
#  [{{:x1, [], :elixir_fn}, [context: My], []}, [do: {:x1, [], :elixir_fn}]]}
# ** (CompileError) m2.exs:12: invalid syntax in def x1()
#     (elixir) lib/enum.ex:675: Enum."-each/2-lists^foreach/1-0-"/2
#     (elixir) lib/enum.ex:675: Enum.each/2
#     m2.exs:12: (module)
