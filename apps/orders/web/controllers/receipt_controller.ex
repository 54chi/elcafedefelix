defmodule Orders.ReceiptController do
  use Orders.Web, :controller
  alias Bolt.Sips, as: Bolt

  def receipts_by_day(conn, %{"fecha" => fecha}) do
    cypher = """
      MATCH (r:Recibo {fecha: #{fecha}})-[:INCLUYE]->(o:Orden)-[:INCLUYE]->(pv)
        WHERE pv:Producto OR pv:Variacion
        RETURN r as Recibo,o as Orden,pv as ProductoVariacion
    """

    recibos = Bolt.query!(Bolt.conn, cypher)
    render(conn, "receipts_by_day.json", %{fecha: fecha, recibos: recibos})
  end
end
