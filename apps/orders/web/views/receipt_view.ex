defmodule Orders.ReceiptView do
  use Orders.Web, :view

  def render("receipts_by_day.json", %{fecha: fecha, recibos: recibos}) do
#    %{ ingredientes: Enum.map(receta, &(Map.get(&1, "insumo")))} |> IO.inspect()
     %{ fecha: fecha, recibos: recibos}
  end

  def render("receipts_by_day.json",_) do
    %{errors: "Error"}
  end


end
