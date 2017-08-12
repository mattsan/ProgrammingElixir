defmodule StringsAndBinaries2 do
  def anagram?(str1, str2) do
    cs1 = String.to_charlist str1
    cs2 = String.to_charlist str2
    Enum.sort(cs1) == Enum.sort(cs2)
  end
end
