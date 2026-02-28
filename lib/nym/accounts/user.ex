defmodule Nym.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :kratos_id, :binary_id

    has_many :clubs, Nym.Clubs.Club, foreign_key: :owner_id
    has_many :memberships, Nym.Clubs.Member

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:kratos_id])
    |> validate_required([:kratos_id])
    |> unique_constraint(:kratos_id)
  end
end
