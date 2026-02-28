defmodule Nym.Kratos do
  @moduledoc "Kratos Public API client"

  def whoami(token) do
    url = "#{kratos_url()}/sessions/whoami"
    headers = [{"X-Session-Token", token}, {"Content-Type", "application/json"}]

    case Req.get(url, headers: headers) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}
      {:ok, %{status: 401}} ->
        {:error, :unauthorized}
      {:ok, %{status: 403}} ->
        {:error, :forbidden}
      _ ->
        {:error, :service_unavailable}
    end
  end

  def kratos_url, do: Application.fetch_env!(:nym, :kratos_public_url)
end
