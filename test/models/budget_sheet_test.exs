defmodule BudjetApi.BudgetSheetTest do
  use BudjetApi.ModelCase

  alias BudjetApi.BudgetSheet
  alias BudjetApi.User
  alias BudjetApi.Repo

  test "changeset with valid attributes" do
    user = insert_user
    attrs = %{name: "February", user_id: user.id}
    changeset = BudgetSheet.changeset(%BudgetSheet{}, attrs)

    assert changeset.valid?
  end

  test "changeset requires name to be a minimum of 5 characters" do
    user = insert_user
    attrs = %{name: "asdf", user_id: user.id}
    changeset = BudgetSheet.changeset(%BudgetSheet{}, attrs)

    refute changeset.valid?
    assert [name: {"should be at least %{count} character(s)", [count: 5]}] == changeset.errors
  end

  test "changeset requires user association to exist" do
    {:error, changeset} = %BudgetSheet{}
    |> BudgetSheet.changeset(%{name: "February", user_id: -12})
    |> Repo.insert

    refute changeset.valid?
    assert {:user, "does not exist"} in changeset.errors
  end

  defp insert_user do
    user_attrs = %{email: "email@example.com", password_digest: "password"}
    user_changeset = User.changeset(%User{}, user_attrs)
    {:ok, user} = Repo.insert(user_changeset)

    user
  end
end
