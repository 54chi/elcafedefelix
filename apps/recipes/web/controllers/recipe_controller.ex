defmodule Recipes.RecipeController do
  use Recipes.Web, :controller
  alias Bolt.Sips, as: Bolt

  def search_by_name(conn, %{"nombre" => nombre}) do
    cypher = """
      MATCH (p:Producto {nombre: \"#{nombre}\"})-[r:NECESITA]->(i)
        RETURN (r.cantidad+" "+r.medida) as cantidad, i.nombre as insumo
    """

    receta = Bolt.query!(Bolt.conn, cypher)
    # [success:
    # %{"fields" => ["cantidad", "insumo"]},
    #   record: ["6 onzas", "Espuma de Leche"],
    #   record: ["1 shots", "Crema Chantilly"],
    #   record: ["2 jigger", "Shot de Espresso"],
    #   record: ["1 onzas", "Sirope de chocolate"],
    #  success: %{"type" => "r"}]
    render(conn, "search_by_name.json", %{nombre: nombre, receta: receta})
  end
end
