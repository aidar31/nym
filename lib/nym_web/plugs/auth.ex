defmodule NymWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  alias Nym.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, identity} <- Nym.Kratos.whoami(token),
         {:ok, user} <-
           find_or_create_user(identity) do
      conn
      |> assign(:current_user, user)
      |> assign(:kratos_identity, identity)
      |> assign(:session_token, token)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{errors: %{detail: "Unauthorized"}})
        |> halt()
    end
  end

  defp find_or_create_user(identity) do
    kratos_id = identity["identity"]["id"]
    Accounts.find_or_create_by_kratos_id(kratos_id, identity)
  end
end
