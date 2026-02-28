defmodule NymWeb.V1.UserResponse do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "UserResponse",
    description: "Информация о текущем пользователе",
    type: :object,
    properties: %{
      data: %Schema{
        type: :object,
        properties: %{
          id: %Schema{type: :string, format: :uuid, description: "Уникальный ID"},
          email: %Schema{type: :string, format: :email, description: "Электронная почта"},
          kratos_id: %Schema{type: :string, format: :uuid, description: "Kratos Identity ID"},
          inserted_at: %Schema{type: :string, format: :"date-time", description: "Дата регистрации"}
        },
        required: [:id, :email]
      }
    },
    example: %{
      "data" => %{
        "id" => "550e8400-e29b-41d4-a716-446655440000",
        "email" => "user@example.com",
        "kratos_id" => "770e8400-e29b-41d4-a716-446655440000",
        "inserted_at" => "2026-02-28T21:51:18Z"
      }
    }
  })
end
