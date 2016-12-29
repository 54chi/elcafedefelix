defmodule Orders.OrderView do
  use Orders.Web, :view

  def render("new_order.json", %{ordenID: ordenID}) do
     ordenID
  end

  def render("update_order.json", %{orden: orden}) do
     orden
  end

  def render("orders_by_id.json", %{id: id, orden: orden}) do
#    %{ ingredientes: Enum.map(receta, &(Map.get(&1, "insumo")))} |> IO.inspect()
     %{ id: id, orden: orden}
  end


  def render("create.json", _) do
    %{error: "error"}
  end



end
