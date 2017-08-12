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
