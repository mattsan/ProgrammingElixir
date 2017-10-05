defmodule My do
  defmacro mydef(name) do
    IO.inspect(quote bind_quoted: [n: name] do
      def unquote(n)(), do: unquote(n)
    end)
  end
end

defmodule Test do
  require My

  [:foo, :bar, :baz] |> Enum.each(fn name -> My.mydef(name) end)
end

# {:__block__, [],
#  [{:=, [], [{:n, [], My}, {:name, [line: 12], nil}]},
#   {:def, [context: My, import: Kernel],
#    [{{:unquote, [], [{:n, [], My}]}, [context: My], []},
#     [do: {:unquote, [], [{:n, [], My}]}]]}]}
