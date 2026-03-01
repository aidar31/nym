defmodule NymWeb.Plugs.FetchMember do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]
  alias Nym.Clubs

  def init(opts), do: opts

  def call(conn, _opts) do
    user = conn.assigns[:current_user]
    club_id = conn.params["club_id"] || conn.params["id"]

    if user && club_id do
      case Clubs.get_member(club_id, user.id) do
        nil ->
          conn
          |> put_status(:forbidden)
          |> json(%{errors: %{detail: "Your not member this club"}})
          |> halt()

        member ->
          assign(conn, :current_member, member)
      end
    else
      conn
    end
  end
end
