defmodule NymWeb.V1.ClubJSON do
  alias Nym.Clubs.Club

  def index(%{clubs: clubs}) do
    %{data: for(club <- clubs, do: data(club))}
  end

  def show(%{club: club}) do
    %{data: data(club)}
  end

  defp data(%Club{} = club) do
    %{
      id: club.id,
      name: club.name,
      description: club.description,
      owner_id: club.owner_id,
      inserted_at: club.inserted_at,
      updated_at: club.updated_at
    }
  end
end
