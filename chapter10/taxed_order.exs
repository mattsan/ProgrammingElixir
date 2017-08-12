defmodule TaxedOrder do
  def tax_orders(taxes, orders) do
    for order <- orders do
      tax_order(taxes, order)
    end
  end

  defp tax_order([], [id, ship_to, net_amount: net_amount]) do
    [id, ship_to, net_amount: net_amount, total_amount: net_amount]
  end

  defp tax_order([{state, rate}|_], [id, ship_to: state, net_amount: net_amount]) do
    [id, ship_to: state, net_amount: net_amount, total_amount: net_amount * (1 + rate)]
  end

  defp tax_order([_|taxes], order) do
    tax_order(taxes, order)
  end
end
