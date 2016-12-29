defmodule Orders.ReceiptController do
  use Orders.Web, :controller
  alias Bolt.Sips, as: Bolt

  require Logger

  # Esto podria ser "index" en vez de show...pero como yo lo veo es que index regresa un solo resultado, y show regresa varios
  def show(conn, %{"fecha" => fecha}) do
    Logger.info " RETORNA recibos con fecha: #{fecha}"

    cypher = """
      MATCH (r:Recibo {fecha: #{fecha}})-[:INCLUYE]->(o:Orden)-[:INCLUYE]->(pv)
        WHERE pv:Producto OR pv:Variacion
        RETURN r as Recibo,o as Orden,pv as ProductoVariacion
    """

    recibos = Bolt.query!(Bolt.conn, cypher)
    render(conn, "receipts_by_day.json", %{fecha: fecha, recibos: recibos})
  end

end
