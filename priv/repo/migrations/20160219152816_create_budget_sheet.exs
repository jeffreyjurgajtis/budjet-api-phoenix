defmodule BudjetApi.Repo.Migrations.CreateBudgetSheet do
  use Ecto.Migration

  def change do
    create table(:budget_sheets) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:budget_sheets, [:user_id])

  end
end
