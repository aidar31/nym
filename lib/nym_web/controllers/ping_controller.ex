defmodule NymWeb.PingController do
  use NymWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias NymWeb.Schemas.PingResponse

  operation(:index,
    summary: "Проверка связи",
    description: "Возращает pong, если сервер жив",
    responses: [
      ok: {"Успешный ответ", "application/json", PingResponse}
    ]
  )

  def index(conn, _params) do
    render(conn, :index, %{message: "ok"})
  end
end
