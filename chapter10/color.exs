# color.exs

defmodule Color do
  def from16to24(bitmap) do
    (for << r::5, g::6, b::5 <- bitmap >>, do: <<r::5, 0::3, g::6, 0::2, b::5, 0::3>>) |> Enum.join
  end

  def from24to16(bitmap) do
    (for << r::5, _::3, g::6, _::2, b::5, _::3 <- bitmap >>, do: <<r::5, g::6, b::5>>) |> Enum.join
  end
end
