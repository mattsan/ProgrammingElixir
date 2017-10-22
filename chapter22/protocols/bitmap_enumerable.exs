defimpl Enumerable, for: Bitmap do
  def count(%Bitmap{value: value}) do
    {:ok, trunc(:math.log2(abs(value))) + 1}
  end

  def member?(bitmap, bit_number) do
    {:ok, 0 <= bit_number && bit_number <= Enum.count(bitmap)}
  end

  def reduce(bitmap, {:cont, acc}, fun) do
    bit_count = Enum.count(bitmap)
    _reduce({bitmap, bit_count}, {:cont, acc}, fun)
  end

  defp _reduce({_bitmap, -1}, {:cont, acc}, _fun) do
    {:done, acc}
  end

  defp _reduce({bitmap, bit_number}, {:cont, acc}, fun) do
    with bit = Bitmap.fetch_bit(bitmap, bit_number), do: _reduce({bitmap, bit_number - 1}, fun.(bit, acc), fun)
  end

  defp _reduce({_bitmap, _bit_number}, {:halt, acc}, _fun) do
    {:halted, acc}
  end

  defp _reduce({bitmap, bit_number}, {:suspend, acc}, fun) do
    {:suspended, acc, &_reduce({bitmap, bit_number}, &1, fun), fun}
  end
end
