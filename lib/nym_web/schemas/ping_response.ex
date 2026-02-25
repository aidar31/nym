defmodule NymWeb.Schemas.PingResponse do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "PingResponse",
    description: "Ping response",
    type: :object,
    properties: %{
      ping: %Schema{type: :string, example: "pong"}
    }
  })
end
