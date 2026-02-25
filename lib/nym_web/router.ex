defmodule NymWeb.Router do
  use NymWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NymWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: NymWeb.ApiSpec
  end

  scope "/api" do
    pipe_through :api

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/api", NymWeb do
    pipe_through :api

    get "/ping", PingController, :index

    scope "/v1", V1 do
    end
  end

  scope "/" do
    pipe_through :browser
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi"
  end
end
