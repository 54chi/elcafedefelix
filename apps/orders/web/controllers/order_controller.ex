#defmodule Producto do
#  @derive [Poison.Encoder]
#  defstruct [:nombre, :cantidad]
#end

#defmodule Variacion do
#  @derive [Poison.Encoder]
#  defstruct [:nombre, :cantidad]
#end

#defmodule ProductoVariacion do
#  @derive [Poison.Encoder]
#  defstruct [:nombre, :cantidad, :variacion]
#end

defmodule Orders.OrderController do
  use Orders.Web, :controller
  alias Bolt.Sips, as: Bolt

  require Poison
  require Logger

#  require IEx

  @moduledoc """
    This is the Orders Controller.
  """

  @doc """
  ### The sins of a programmer:

  * I could use the auto-generated ID from Neo4J, which is safer, but I will defer on that for now.
  * I can also create unique constraints on the "id"s to avoid duplicates
  * The stuff I'm returning to my views needs to be customized too, so it can add some value
  * Also missing validation
  * The whole missing security part is in my todo and should be coming...eventually
  * Could use some structs

  ### To Do:

  [x] Open an Order
  [x] Update an order: add a Product
  [x] Update an order: add a variation to a Product
  [ ] Update an order: assign client
  [x] Show an order by ID
  [x] Delete an order

  Note that there is another controller needed: "receipts", to be used to combine orders and connect to payment

  # recibo incluye orden
  # orden incluye productos
  # orden incluye {cantidad} variacion
  # orden: id, fecha, hora, total. <id>

  """

  # CREA UNA ORDEN
  def create(conn, %{"id" => id, "fecha" => fecha, "hora" => hora, "cliente" => cliente}) do
      Logger.info " CREA una orden para el cliente de nombre #{cliente}"
      cypher = """
        MATCH (_c:Cliente {nombre: "#{cliente}"})
        CREATE
          (_o:Orden {id:"#{id}", fecha: #{fecha}, hora: #{hora}}),
          (_c)-[:COLOCA]->(_o)
        RETURN
          ID(_o) as ordenID
      """
      ordenID = Bolt.query!(Bolt.conn, cypher)
      render(conn, "new_order.json", %{ordenID: ordenID})
  end

  # AGREGAR PRODUCTO A LA ORDEN
  def update(conn, %{"id" => id, "producto" => product_params}) do
      # IEx.pry
      Logger.info " AGREGA un producto a la orden con id #{id}"
      prodAttrs = %{nombre: product_params["nombre"], cantidad: product_params["cantidad"]}

      Logger.info " Buscamos la orden, buscamos el producto y los conectamos"

      cypher = """
        MATCH (_o:Orden {id: "#{id}"}), (_p:Producto {nombre: "#{prodAttrs.nombre}"})
        CREATE
          (_o)-[r:INCLUYE {cantidad: #{prodAttrs.cantidad}}]->(_p)
        RETURN
          ID(_o) as ordenID
      """
      ordenID = Bolt.query!(Bolt.conn, cypher)
      render(conn, "new_order.json", %{ordenID: ordenID})
  end

  # AGREGAR VARIACION A LA ORDEN
  def update(conn, %{"id" => id, "variacion" => var_params}) do
      Logger.info " AGREGA una variacion a la orden con id #{id}"
      varAttrs = %{nombre: var_params["nombre"], cantidad: var_params["cantidad"]}

      Logger.info " Buscamos la orden, buscamos la variacion y los conectamos"

      cypher = """
        MATCH (_o:Orden {id: "#{id}"}), (_v:Variacion {nombre: "#{varAttrs.nombre}"})
        CREATE
          (_o)-[r:INCLUYE {cantidad: #{varAttrs.cantidad}}]->(_v)
        RETURN
          ID(_o) as ordenID
      """
      ordenID = Bolt.query!(Bolt.conn, cypher)
      render(conn, "new_order.json", %{ordenID: ordenID})
  end

  # MOSTRAR ORDENES POR ID
  def index(conn, %{"id" => id}) do
    Logger.info " MOSTRAR orden con id #{id}"
    cypher = """
      MATCH (o:Orden {id: "#{id}"})
      OPTIONAL MATCH (o)-[r:INCLUYE]-(x) //drops p's relations
      RETURN r, x
    """
    orden = Bolt.query!(Bolt.conn, cypher)
    render(conn, "orders_by_id.json", %{id: id, orden: orden})
  end

  # BORRAR ORDENES POR ID
  def delete(conn, %{"id" => id}) do
    Logger.info " BORRA la orden con id: #{id}"
    cypher = """
      MATCH (o:Orden {id: "#{id}"})
      OPTIONAL MATCH (o)-[r]-() //drops p's relations
      DELETE r,o
    """
    ordenID = Bolt.query!(Bolt.conn, cypher)
    render(conn, "new_order.json", %{ordenID: ordenID})
  end
end
