defmodule My do
  defmacro macro(name) do
    IO.inspect quote do: def unquote(name)(), do: unquote(name)
  end
end

defmodule Test do
  require My

  My.macro(:foo)
  My.macro(:bar)
  My.macro(:baz)
end

# {:def, [context: My, import: Kernel], [{:foo, [context: My], []}, [do: :foo]]}
# {:def, [context: My, import: Kernel], [{:bar, [context: My], []}, [do: :bar]]}
# {:def, [context: My, import: Kernel], [{:baz, [context: My], []}, [do: :baz]]}
