### ガード節なし

#### コード

```elixir
quote do
  def foo(a) do
    a * a
  end
end
```

#### 結果

```elixir
{:def, [context: Elixir, import: Kernel],
 [{:foo, [context: Elixir], [{:a, [], Elixir}]},
  [do: {:*, [context: Elixir, import: Kernel],
    [{:a, [], Elixir}, {:a, [], Elixir}]}]]}
```

#### 結果（書き下したもの）

```elixir
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

### ガード節あり

#### コード

```elixir
quote do
  def foo(a) when a < 10 do
    a * a
  end
end
```

#### 結果

```elixir
{:def, [context: Elixir, import: Kernel],
 [{:when, [context: Elixir],
   [{:foo, [], [{:a, [], Elixir}]},
    {:<, [context: Elixir, import: Kernel], [{:a, [], Elixir}, 10]}]},
  [do: {:*, [context: Elixir, import: Kernel],
    [{:a, [], Elixir}, {:a, [], Elixir}]}]]}
```

#### 結果（書き下したもの）

```elixir
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

