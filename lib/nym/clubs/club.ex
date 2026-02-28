defmodule Nym.Clubs.Club do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "clubs" do
    field :name, :string
    field :slug, :string
    field :description, :string
    field :is_private, :boolean, default: false

    belongs_to :owner, Nym.Accounts.User
    has_many :members, Nym.Clubs.Member

    timestamps(type: :utc_datetime)
  end

  def changeset(club, attrs) do
    club
    |> cast(attrs, [:name, :slug, :description, :is_private, :owner_id])
    |> validate_required([:name, :slug, :owner_id])
    |> unique_constraint(:slug)
  end
end
