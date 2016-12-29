defmodule Orders.Router do
  use Orders.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Orders do
    pipe_through :api

    resources "/orders", OrderController
    get "/recibos", ReceiptController, :show

    #resources "/recibos", ReceiptController, only: [:show]

# crear un recibo
# agregar ordenes al reecibo
# agregar productos a la orden
# agregar variaciones a la ordenes


  end
end
