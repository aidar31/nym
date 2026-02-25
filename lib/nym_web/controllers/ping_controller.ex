defmodule NymWeb.PingController do
  use NymWeb, :controller

  def index(conn, _params) do
    render(conn, :index, %{message: "ok"})
  end
end
