defmodule NymWeb.V1.UserController do
  alias NymWeb.V1.UserResponse
  use NymWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias OpenApiSpex.Schema

  tags ["users"]
  operation(:me,
    summary: "Получение информации о себе",
    security: [%{"authorization" => []}],
    responses: [
      ok: {"Успешный ответ", "application/json", UserResponse},
      unauthorized:
        {"Ошибка", "application/json",
         %Schema{
           type: :object,
           properties: %{
             error: %Schema{type: :string, example: "unauthorized"}
           }
         }}
    ]
  )

  def me(conn, _params) do
    identity = conn.assigns.current_user
    render(conn, :me, identity: identity)
  end
end
