defmodule Nym.Clubs.Club do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "clubs" do
    field :name, :string
    field :description, :string
    field :is_private, :boolean, default: false

    belongs_to :owner, Nym.Accounts.User
    has_many :members, Nym.Clubs.Member

    timestamps(type: :utc_datetime)
  end

  def changeset(club, attrs) do
    club
    |> cast(attrs, [:name, :description, :is_private, :owner_id])
    |> validate_required([:name, :owner_id])
  end

  def update_changeset(club, attrs) do
    club
    |> cast(attrs, [:name, :description, :is_private])
    |> validate_required([:name])
    |> validate_length(:name, min: 3, max: 100)
  end
end
