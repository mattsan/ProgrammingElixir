defmodule StringsAndBinaries1 do
  def printable?(charlist) do
    charlist |> Enum.all?(&(&1 in (?\s..?~)))
  end
end
