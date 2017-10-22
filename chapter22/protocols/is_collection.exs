defprotocol Collection do
  @fallback_to_any true
  def is_collection?(value)
end

defimpl Collection, for: [List, Tuple, BitString, Map] do
  def is_collection?(_), do: true
end

defimpl Collection, for: Any do
  def is_collection?(_), do: false
end

Enum.each [1, 1.0, [1,2], {1,2}, %{}, "cat"], &(IO.puts "#{inspect &1}: #{Collection.is_collection?(&1)}")

# 1: false
# 1.0: false
# [1, 2]: true
# {1, 2}: true
# %{}: true
# "cat": true
