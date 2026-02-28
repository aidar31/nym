defmodule NymWeb.V1.UserJSON do
  def me(%{identity: session}) do
    user = session["identity"]

    %{
      data: %{
        id: user["id"],
        email: get_in(user, ["traits", "email"]),
        username: get_in(user, ["traits", "name", "first"]),
        inserted_at: user["created_at"]
      }
    }
  end
end
