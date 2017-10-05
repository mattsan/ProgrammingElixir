defmodule My do
  defmacro macro(name) do
    IO.inspect quote bind_quoted: [n: name], do: def unquote(n)(), do: unquote(n)
  end
end

defmodule Test do
  require My

  [:foo, :bar, :baz] |> Enum.each(fn name -> My.macro(name) end)
end

# {:__block__, [],
#  [{:=, [], [{:n, [], My}, {:name, [line: 10], nil}]},
#   {:def, [context: My, import: Kernel],
#    [{{:unquote, [], [{:n, [], My}]}, [context: My], []},
#     [do: {:unquote, [], [{:n, [], My}]}]]}]}
