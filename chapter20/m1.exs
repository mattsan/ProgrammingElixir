defmodule My do
  defmacro mydef(name) do
    IO.inspect(quote do
      def unquote(name)(), do: unquote(name)
    end)
  end
end

defmodule Test do
  require My

  My.mydef(:foo)
  My.mydef(:bar)
  My.mydef(:baz)
end

# {:def, [context: My, import: Kernel], [{:foo, [context: My], []}, [do: :foo]]}
# {:def, [context: My, import: Kernel], [{:bar, [context: My], []}, [do: :bar]]}
# {:def, [context: My, import: Kernel], [{:baz, [context: My], []}, [do: :baz]]}
