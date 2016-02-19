defmodule BudjetApi.Repo.Migrations.CreateApiKey do
  use Ecto.Migration

  def change do
    create table(:api_keys) do
      add :expires_at, :datetime
      add :secret, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:api_keys, [:user_id])

  end
end
