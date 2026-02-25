defmodule NymWeb.Router do
  use NymWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NymWeb do
    pipe_through :api

    get "/ping", PingController, :index

    scope "/v1", V1 do
    end
  end
end
