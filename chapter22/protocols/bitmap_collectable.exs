defimpl Collectable, for: Bitmap do
  use Bitwise

  def into(%Bitmap{value: target}) do
    {target, &into/2}
  end

  defp into(acc, {:cont, next_bit}) do
    (acc <<< 1) ||| next_bit
  end

  defp into(acc, :done) do
    %Bitmap{value: acc}
  end

  defp into(_, :halt) do
    :ok
  end
end
