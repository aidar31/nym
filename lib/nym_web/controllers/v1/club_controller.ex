defmodule NymWeb.V1.ClubController do
  use NymWeb, :controller

  alias Nym.Clubs

  action_fallback NymWeb.FallbackController

  def index(conn, _params) do
    clubs = Clubs.get_public_clubs()
    render(conn, :index, clubs: clubs)
  end

  def update(conn, %{"id" => id} = club_params) do
    member = conn.assigns.current_member

    with {:ok, club} <- Clubs.fetch_club(id),
         {:ok, updated_club} <- Clubs.update_club(club, club_params, member) do
      render(conn, :show, club: updated_club)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, club} <- Clubs.fetch_club(id) do
      render(conn, :show, club: club)
    end
  end

  def create(conn, club_params) do
    user = conn.assigns.current_user

    with {:ok, %{club: club}} <- Clubs.create_club(user, club_params) do
      conn
      |> put_status(:created)
      |> render(:show, club: club)
    end
  end
end
