defmodule NymWeb.FallbackController do
  use NymWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: NymWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: NymWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, status}) when is_atom(status) do
    conn
    |> put_status(status)
    |> put_view(json: NymWeb.ErrorJSON)
    |> render(status)
  end
end
