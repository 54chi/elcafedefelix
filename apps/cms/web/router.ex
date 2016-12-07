defmodule Cms.Router do
  use Cms.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Cms do
    pipe_through :api
  end
end
