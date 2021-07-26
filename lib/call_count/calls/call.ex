defmodule CallCount.Calls.Call do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calls" do
    field :tenantId, :string
    field :clientId, :string
    field :day, :integer
    field :hour, :integer
    field :month, :integer
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(call, attrs) do
    call
    |> cast(attrs, [:tenantId, :clientId, :year, :month, :day, :hour])
    |> validate_required([:tenantId, :clientId, :year, :month, :day, :hour])
  end
end
