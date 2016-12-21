defmodule Orders.Router do
  use Orders.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Orders do
    pipe_through :api

    get "/recibos", ReceiptController, :receipts_by_day
  end
end
