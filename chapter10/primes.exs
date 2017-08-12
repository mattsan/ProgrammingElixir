defmodule Primes do
  def prime_numbers(upper_limit) do
    prime_numbers(Enum.to_list(2..upper_limit), [])
  end

  defp prime_numbers([], acc) do
    Enum.reverse(acc)
  end

  defp prime_numbers([p|rest], acc) do
    prime_numbers((for r <- rest, rem(r, p) != 0, do: r), [p|acc])
  end
end

defmodule Primes2 do
  def prime_numbers([]), do: []
  def prime_numbers([p|rest]), do: [p|prime_numbers(for r <- rest, rem(r, p) != 0, do: r)]
end
