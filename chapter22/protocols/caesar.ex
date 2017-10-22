defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(&shift_char(&1, shift))
  end

  def rot13(string), do: encrypt(string, 13)

  defp shift_char(c, shift) when c in ?a..?z do
    Enum.at(?a..?z, rem(c - ?a + shift, 26))
  end
  defp shift_char(c, _), do: c
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.to_charlist
    |> Caesar.List.encrypt(shift)
    |> List.to_string
  end

  def rot13(string), do: encrypt(string, 13)
end

IO.inspect Caesar.encrypt("abc", 1)
IO.inspect Caesar.encrypt('abc', 1)
IO.inspect Caesar.encrypt("abc", 13)
IO.inspect Caesar.encrypt('abc', 13)
IO.inspect Caesar.rot13("abc")
IO.inspect Caesar.rot13('abc')
