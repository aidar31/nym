defmodule Nym.Clubs.Member do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "club_members" do
    field :display_name, :string
    field :avatar_url, :string
    field :role, :string, default: "member"
    field :joined_at, :utc_datetime

    belongs_to :club, Nym.Clubs.Club
    belongs_to :user, Nym.Accounts.User

    has_many :posts, Nym.Posts.Post, foreign_key: :author_id
    has_many :permissions, Nym.Clubs.Permission

    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc """
  Changeset для вступления в клуб.
  """
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:club_id, :user_id, :display_name, :avatar_url, :role, :joined_at])
    |> validate_required([:club_id, :user_id])
    |> validate_inclusion(:role, ["owner", "moderator", "member"])
    |> unique_constraint([:club_id, :user_id], name: :club_members_club_id_user_id_index)
  end
end
