defmodule CallCount.Calls do
  @moduledoc """
  The Calls context.
  """

  import Ecto.Query, warn: false
  alias CallCount.Repo

  alias CallCount.Calls.Call

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(CallCount.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(CallCount.PubSub, @topic, {__MODULE__, event, result})

    {:ok, result}
  end

  @doc """
  Returns the list of calls.

  ## Examples

      iex> list_calls()
      [%Call{}, ...]

  """
  def list_calls do
    Repo.all(Call)
  end

  @doc """
  Gets a single call.

  Raises `Ecto.NoResultsError` if the Call does not exist.

  ## Examples

      iex> get_call!(123)
      %Call{}

      iex> get_call!(456)
      ** (Ecto.NoResultsError)

  """
  def get_call!(id), do: Repo.get!(Call, id)

  @doc """
  Creates a call.

  ## Examples

      iex> create_call(%{field: value})
      {:ok, %Call{}}

      iex> create_call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_call(attrs \\ %{}) do
    %Call{}
    |> Call.changeset(attrs)
    |> Repo.insert()

    |> broadcast_change([:call, :created])
  end

  @doc """
  Updates a call.

  ## Examples

      iex> update_call(call, %{field: new_value})
      {:ok, %Call{}}

      iex> update_call(call, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_call(%Call{} = call, attrs) do
    call
    |> Call.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a call.

  ## Examples

      iex> delete_call(call)
      {:ok, %Call{}}

      iex> delete_call(call)
      {:error, %Ecto.Changeset{}}

  """
  def delete_call(%Call{} = call) do
    Repo.delete(call)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking call changes.

  ## Examples

      iex> change_call(call)
      %Ecto.Changeset{data: %Call{}}

  """
  def change_call(%Call{} = call, attrs \\ %{}) do
    Call.changeset(call, attrs)
  end

  def calls_today(tenantId) do
    now = DateTime.utc_now()
    midnight = Timex.shift(now, hours: -(now.hour), minutes: -(now.minute), seconds: -(now.second))

    calls = Call
    |> where([c], c.tenantId == ^tenantId)
    |> where([c], c.inserted_at >= ^midnight)
    |> select([c], count(c.id))
    |> Repo.all()
    |> Enum.at(0)

    calls
  end

  def calls_this_month(tenantId) do

    monthly = DateTime.utc_now() |> Timex.beginning_of_month()

    calls = Call
    |> where([c], c.tenantId == ^tenantId)
    |> where([c], c.inserted_at >= ^monthly)
    |> select([c], count(c.id))
    |> Repo.all()
    |> Enum.at(0)

    calls
  end

  def calls_this_year(tenantId) do
    now = DateTime.utc_now()
    yearly = Timex.shift(now, months: -(now.month - 1), days: -(now.day - 1), hours: -(now.hour), minutes: -(now.minute), seconds: -(now.second))

    calls = Call
    |> where([c], c.tenantId == ^tenantId)
    |> where([c], c.inserted_at >= ^yearly)
    |> select([c], count(c.id))
    |> Repo.all()
    |> Enum.at(0)

    calls
  end

  def client_call_count(tenantId) do
    calls= Call
    |> where([c], c.tenantId == ^tenantId)
    |> group_by([c], c.clientId)
    |> select([c], {c.clientId, count(c.id)})
    |> Repo.all()

    calls
  end

  def calls_per_day(tenantId) do
    month = DateTime.utc_now() |> Timex.beginning_of_month()

    calls= Call
    |> where([c], c.tenantId == ^tenantId)
    |> where([c], c.inserted_at >= ^month)
    |> group_by([c], fragment("date(?)", c.inserted_at))
    |> select([c], %{date: fragment("date(?)", c.inserted_at), count: count(c.id)})
    |> order_by([c], asc: fragment("date(?)", c.inserted_at))
    |> Repo.all()

    calls
  end
end
