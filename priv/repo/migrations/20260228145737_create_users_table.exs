defmodule Nym.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :kratos_id, :binary_id, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:kratos_id])
  end
end
