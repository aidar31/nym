defmodule NymWeb.PingJSON do
  def index(%{message: msg}) do
    %{
      status: "ok",
      data: %{
        message: msg,
        time: DateTime.utc_now()
      }
    }
  end
end
