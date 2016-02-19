ExUnit.start

Mix.Task.run "ecto.create", ~w(-r BudjetApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r BudjetApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(BudjetApi.Repo)

