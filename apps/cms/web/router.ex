defmodule Cms.Router do
  use Cms.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

#  scope "/api", Cms do
#    pipe_through :api
#  end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Cms.Schema

  forward "/", Absinthe.Plug,
    schema: Cms.Schema

end
