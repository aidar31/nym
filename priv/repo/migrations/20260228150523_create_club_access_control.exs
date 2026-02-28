defmodule Nym.Repo.Migrations.CreateClubAccessControl do
  use Ecto.Migration

  def change do
    create table(:club_permissions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :club_member_id, references(:club_members, type: :binary_id, on_delete: :delete_all), null: false
      add :permission, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create table(:club_invites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :club_id, references(:clubs, type: :binary_id, on_delete: :delete_all)
      add :created_by_id, references(:club_members, type: :binary_id, on_delete: :nilify_all), null: false
      add :code, :string, null: false
      add :max_uses, :integer
      add :uses_count, :integer, default: 0, null: false
      add :expires_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:club_invites, [:code])

    create table(:club_join_requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :club_id, references(:clubs, type: :binary_id, on_delete: :delete_all), null: false
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :status, :string, default: "pending", null: false
      add :reviewed_by_id, references(:club_members, type: :binary_id, on_delete: :nilify_all)
      add :reviewed_at, :utc_datetime

      timestamps(updated_at: false)
    end
  end
end
