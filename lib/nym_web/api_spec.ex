defmodule NymWeb.ApiSpec do
  alias OpenApiSpex.{OpenApi, Info, Server, Paths}
  @behaviour

  @impl OpenApi
  def spec do
    %OpenApi{
      info: %Info{
        title: "Nym API",
        version: "1.0.0",
        description: "Docs for API"
      },
      paths: Paths.from_router(NymWeb.Router),
      servers: [Server.from_endpoint(NymWeb.Endpoint)]
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
