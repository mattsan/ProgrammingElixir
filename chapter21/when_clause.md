
```elixir:ガード節なし
quote do
  def foo(a) do
    a * a
  end
end
```

```elixir:結果
{:def, [context: Elixir, import: Kernel],
 [{:foo, [context: Elixir], [{:a, [], Elixir}]},
  [do: {:*, [context: Elixir, import: Kernel],
    [{:a, [], Elixir}, {:a, [], Elixir}]}]]}
```

```elixir:結果（書き下したもの）
{
  :def,
  [context: Elixir, import: Kernel],
  [
    {
      :foo,               # name
      [context: Elixir],
      [{:a, [], Elixir}]  # args
    },
    [
      :do,
      {:*, [context: Elixir, import: Kernel], [{:a, [], Elixir}, {:a, [], Elixir}]} # content
    ]
  ]
}
```

```elixir:ガード節あり
quote do
  def foo(a) when a < 10 do
    a * a
  end
end
```

```elixir:結果
{:def, [context: Elixir, import: Kernel],
 [{:when, [context: Elixir],
   [{:foo, [], [{:a, [], Elixir}]},
    {:<, [context: Elixir, import: Kernel], [{:a, [], Elixir}, 10]}]},
  [do: {:*, [context: Elixir, import: Kernel],
    [{:a, [], Elixir}, {:a, [], Elixir}]}]]}
```

```elixir:結果（書き下したもの）
{
  :def,
  [context: Elixir, import: Kernel],
  [
    {
      :when,
      [context: Elixir],
      [
        {
          :foo,               # name
          [],
          [{:a, [], Elixir}]  # args
        },
        {:<, [context: Elixir, import: Kernel], [{:a, [], Elixir}, 10]} # a < 10
      ]
    },
    [
      :do,
      {:*, [context: Elixir, import: Kernel], [{:a, [], Elixir}, {:a, [], Elixir}]} # content
    ]
  ]
}
```

