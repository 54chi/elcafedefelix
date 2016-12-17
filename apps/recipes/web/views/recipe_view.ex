defmodule Recipes.RecipeView do
  use Recipes.Web, :view

  def render("search_by_name.json", %{nombre: nombre, receta: receta}) do
#    %{ ingredientes: Enum.map(receta, &(Map.get(&1, "insumo")))} |> IO.inspect()
     %{ receta: nombre, ingredientes: receta}
  end


end
