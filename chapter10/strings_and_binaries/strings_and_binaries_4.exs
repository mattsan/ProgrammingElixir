defmodule StringsAndBinaries4 do
  def calculate(cs) do
    {lhs, [op|rhs]} = Enum.split_while cs, &(&1 in (?0..?9))
    calculate(List.to_integer(lhs), op, List.to_integer(rhs))
  end

  defp calculate(lhs, ?+, rhs), do: lhs + rhs
  defp calculate(lhs, ?-, rhs), do: lhs - rhs
  defp calculate(lhs, ?*, rhs), do: lhs * rhs
  defp calculate(lhs, ?/, rhs), do: div(lhs, rhs)
end
