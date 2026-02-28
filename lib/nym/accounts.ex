defmodule Nym.Accounts do
  alias Nym.Repo
  alias Nym.Accounts.User

  def find_or_create_by_kratos_id(kratos_id, identity) do
    case Repo.get_by(User, kratos_id: kratos_id) do
      %User{} = user ->
        {:ok, user}

      nil ->
        %User{}
        |> User.changeset(%{
          kratos_id: kratos_id,
          email: get_in(identity, ["identity", "traits", "email"])
        })
        |> Repo.insert()
    end
  end
end
