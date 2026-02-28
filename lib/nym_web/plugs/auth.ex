defmodule NymWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
      {:ok, identity} <- Nym.Kratos.whoami(token) do
        conn
        |> assign(:current_user, identity)
        |> assign(:session_token, token)
      else
        _ ->
          conn
          |> put_status(:unauthorized)
          |> json(%{errors: %{detail: "Unauthorized"}})
          |> halt()
      end
  end
end
