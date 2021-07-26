defmodule CallCountWeb.DashboardLive do
  use CallCountWeb, :live_view

  alias CallCount.Calls

  def mount(_params, _session, socket) do
    Calls.subscribe()

    {:ok, fetch(socket)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({Calls, [:call | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    tenantId = "56789"

    calls_today = Calls.calls_today(tenantId) |> Integer.to_string()
    calls_monthly = Calls.calls_this_month(tenantId) |> Integer.to_string()
    calls_yearly = Calls.calls_this_year(tenantId) |> Integer.to_string()

    assign(socket, calls_today: calls_today, calls_monthly: calls_monthly, calls_yearly: calls_yearly)
  end

end
