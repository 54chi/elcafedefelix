defmodule Recipes.Router do
  use Recipes.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Recipes do
    pipe_through :api

    get "/recipes", RecipeController, :search_by_name
  end
end
