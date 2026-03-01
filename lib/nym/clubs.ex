defmodule Nym.Clubs do
  alias Ecto.Multi
  alias Nym.Repo
  alias Nym.Clubs.{Club, Member}
  alias Nym.Accounts.User
  alias Nym.Clubs.Policy

  def get_member(club_id, user_id), do: Repo.get_by(Member, club_id: club_id, user_id: user_id)

  @doc """
  Creates a new club owned by the given user.

  Runs inside a transaction. The creator is automatically added
  as a member with the "owner" role.

  Returns:
    * `{:ok, %{club: club, member: member}}`
    * `{:error, failed_operation, changeset, changes_so_far}`
  """
  @spec create_club(User.t(), map()) ::
          {:ok, %{club: Club.t(), member: Member.t()}}
          | {:error, atom(), Ecto.Changeset.t(), map()}
  def create_club(user, attrs) do
    display_name = Map.get(attrs, "display_name", "Основатель")

    Multi.new()
    |> Multi.insert(:club, Club.changeset(%Club{owner_id: user.id}, attrs))
    |> Multi.insert(:member, fn %{club: club} ->
      Member.owner_changeset(%Member{}, %{
        club_id: club.id,
        user_id: user.id,
        display_name: display_name
      })
    end)
    |> Repo.transaction()
  end

  def update_club(%Club{} = club, attrs, _member) do
    club
    |> Club.update_changeset(attrs)
    |> Repo.update()
  end

  def update_club(%Club{}, _attrs, %Member{}) do
    {:error, :forbidden}
  end

  def fetch_club(id) do
    case get_club_by_id(id) do
      nil -> {:error, :not_found}
      club -> {:ok, club}
    end
  end

  def get_public_clubs do
    Club |> Repo.all_by(is_private: false)
  end

  defp get_club_by_id(id), do: Repo.get_by(Club, id: id)
end
