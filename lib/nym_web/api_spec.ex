defmodule NymWeb.ApiSpec do
  alias OpenApiSpex.SecurityScheme
  alias OpenApiSpex.{OpenApi, Info, Server, Paths, Components}
  @behaviour

  @impl OpenApiSpex.OpenApi
  def spec do
    %OpenApi{
      info: %Info{
        title: "Nym API",
        version: "1.0.0",
        description: "Docs for API"
      },
      components: %Components{
        securitySchemes: %{
          "authorization" => %SecurityScheme{
            type: "http",
            scheme: "bearer",
            bearerFormat: "Token",
            description: "Secret token"
          }
        }
      },
      paths: Paths.from_router(NymWeb.Router),
      servers: [Server.from_endpoint(NymWeb.Endpoint)]
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
