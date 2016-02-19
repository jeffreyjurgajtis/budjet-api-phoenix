defmodule BudjetApi.BudgetSheetControllerTest do
  use BudjetApi.ConnCase

  alias BudjetApi.BudgetSheet
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, budget_sheet_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    budget_sheet = Repo.insert! %BudgetSheet{}
    conn = get conn, budget_sheet_path(conn, :show, budget_sheet)
    assert json_response(conn, 200)["data"] == %{"id" => budget_sheet.id,
      "name" => budget_sheet.name,
      "user_id" => budget_sheet.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, budget_sheet_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, budget_sheet_path(conn, :create), budget_sheet: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(BudgetSheet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, budget_sheet_path(conn, :create), budget_sheet: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    budget_sheet = Repo.insert! %BudgetSheet{}
    conn = put conn, budget_sheet_path(conn, :update, budget_sheet), budget_sheet: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(BudgetSheet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    budget_sheet = Repo.insert! %BudgetSheet{}
    conn = put conn, budget_sheet_path(conn, :update, budget_sheet), budget_sheet: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    budget_sheet = Repo.insert! %BudgetSheet{}
    conn = delete conn, budget_sheet_path(conn, :delete, budget_sheet)
    assert response(conn, 204)
    refute Repo.get(BudgetSheet, budget_sheet.id)
  end
end
