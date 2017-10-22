defmodule CsvSigil do
  def sigil_v(lines, opts) do
    result = to_csv(lines)

    case opts do
    'h' ->
      [h|body] = result
      header = Enum.map(h, &String.to_atom/1)
      Enum.map(body, &(Enum.zip(header, all_to_float(&1))))
    _ ->
      Enum.map(result, &all_to_float/1)
    end
  end

  defp to_float(f) do
    case Float.parse(f) do
      {n, ""} -> n
      _       -> f
    end
  end

  defp all_to_float(fs) do
    Enum.map(fs, &to_float/1)
  end

  defp to_csv(lines) do
    lines
    |> String.trim_trailing
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end
end

defmodule Example do
  import CsvSigil

  def show_csv do
    IO.inspect ~v"""
               1,2,3
               cat,dog
               """
  end

  def show_csv_with_header do
    IO.inspect  ~v"""
                Item,Qty,Price
                Teddy bear,4,34.95
                Milk,1,2.99
                Battery,6,8.00
                """h
  end
end

Example.show_csv
Example.show_csv_with_header
