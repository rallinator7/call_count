defmodule CallCount.Repo.Migrations.CreateCalls do
  use Ecto.Migration

  def change do
    create table(:calls) do
      add :clientId, :string
      add :year, :integer
      add :month, :integer
      add :day, :integer
      add :hour, :integer

      timestamps()
    end

  end
end
