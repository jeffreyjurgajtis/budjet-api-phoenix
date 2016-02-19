defmodule BudjetApi.BudgetSheetControllerTest do
  use BudjetApi.ConnCase

  alias BudjetApi.BudgetSheet
  alias BudjetApi.User
  alias BudjetApi.Repo

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    user = insert_user

    %BudgetSheet{}
    |> BudgetSheet.changeset(%{name: "February", user_id: user.id})
    |> Repo.insert

    conn = get conn, budget_sheet_path(conn, :index)
    assert json_response(conn, 200)["budget_sheet"] != []
  end

  test "shows chosen resource", %{conn: conn} do
    user = insert_user

    budget_sheet = %BudgetSheet{}
    |> BudgetSheet.changeset(%{name: "February", user_id: user.id})
    |> Repo.insert!

    conn = get conn, budget_sheet_path(conn, :show, budget_sheet)
    assert Map.take(json_response(conn, 200)["budget_sheet"], ["id", "name", "links"]) == %{
      "id" => budget_sheet.id,
      "name" => budget_sheet.name,
      "links" => []
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, budget_sheet_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    insert_user
    conn = post conn, budget_sheet_path(conn, :create), budget_sheet: @valid_attrs
    assert json_response(conn, 201)["budget_sheet"]["id"]
    assert Repo.get_by(BudgetSheet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    insert_user
    conn = post conn, budget_sheet_path(conn, :create), budget_sheet: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = insert_user

    budget_sheet = %BudgetSheet{}
    |> BudgetSheet.changeset(%{name: "February", user_id: user.id})
    |> Repo.insert!

    conn = delete conn, budget_sheet_path(conn, :delete, budget_sheet)
    assert response(conn, 204)
    refute Repo.get(BudgetSheet, budget_sheet.id)
  end

  defp insert_user do
    %User{}
    |> User.changeset(%{email: "test@example.com", password_digest: "password"})
    |> Repo.insert!
  end
end
