`Stream.resource` & `Enum.to_list` を自分で実装してみると動きが理解しやすくなると思う。

試みにやってみた実装：

```elixir
# my_stream.exs
defmodule MyStream do
  def resource(start_fun, next_fun, after_fun) do
    itr = fn
      (:start) ->
        rsc = start_fun.()
      ({:halt, rsc}) ->
        after_fun.(rsc)
      (rsc) ->
        next_fun.(rsc)
    end
    {:resource, itr}
  end
end

defmodule MyEnum do
  def to_list({:resource, itr}) do
    rsc = itr.(:start)
    to_list({:resource, itr, itr.(rsc), []})
  end

  def to_list({:resource, itr, {:halt, rsc}, acc}) do
    itr.({:halt, rsc})
    acc
  end

  def to_list({:resource, itr, {value, rsc}, acc}) do
    to_list({:resource, itr, itr.(rsc), acc ++ value})
  end

  def to_list(enumerable) do
    # それ以外は Enum.to_list に丸投げ
    Enum.to_list(enumerable)
  end
end
```




```elixir
start_fun = fn -> File.open!("sample") end

next_fun = fn file ->
  case IO.read(file, :line) do
    data when is_binary(data) -> {[data], file}
    _ -> {:halt, file}
  end
end

after_fun = fn file -> File.close(file) end

# ライブラリの Stream.resource と Enum.to_list
rsc = Stream.resource(start_fun, next_fun, after_fun)
Enum.to_list(rsc)

# 自前実装の Stream.resource と Enum.to_list
rsc = MyStream.resource(start_fun, next_fun, after_fun)
MyEnum.to_list(rsc)
```
