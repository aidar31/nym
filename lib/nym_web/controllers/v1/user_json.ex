defmodule NymWeb.V1.UserJSON do
  def me(%{user: user, identity: identity}) do
    %{
      data: %{
        id: user.id,
        kratos_id: user.kratos_id,
        email: get_in(identity, ["identity", "traits", "email"]),
        inserted_at: user.inserted_at
      }
    }
  end
end
