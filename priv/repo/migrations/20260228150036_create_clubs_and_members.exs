defmodule Nym.Repo.Migrations.CreateClubsAndMembers do
  use Ecto.Migration

  def change do
    create table(:clubs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :owner_id, references(:users, type: :binary_id, on_delete: :delete_all)
      add :name, :string, null: false
      add :description, :text
      add :is_private, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create table(:club_members, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :club_id, references(:clubs, type: :binary_id, on_delete: :delete_all)
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      add :display_name, :string
      add :avatar_url, :string
      add :role, :string, default: "member", null: false
      add :joined_at, :utc_datetime, default: fragment("now()")

      timestamps(type: :utc_datetime)
    end

    create unique_index(:club_members, [:club_id, :user_id])
  end
end
