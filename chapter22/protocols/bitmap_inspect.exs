defimpl Inspect, for: Bitmap do
  def inspect(%Bitmap{value: value}, _opts) do
    "%Bitmap{#{value}=#{as_binary(value)}}"
  end

  defp as_binary(value) do
    to_string(:io_lib.format("~.2B", [value]))
  end
end
