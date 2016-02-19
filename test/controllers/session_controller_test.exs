defmodule BudjetApi.SessionControllerTest do
  use BudjetApi.ConnCase

  alias BudjetApi.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "renders user for email provided in request params", %{conn: conn} do
    user = insert_user
    attrs = %{email: user.email, password: "password"}
    conn = post(conn, session_path(conn, :create), session: attrs)

    assert json_response(conn, 201)["user"]["email"]
  end

  test "renders errors for nonexistent email in request params", %{conn: conn} do
    insert_user
    attrs = %{email: "invalid@example.com", password: "password"}
    conn = post(conn, session_path(conn, :create), session: attrs)

    assert json_response(conn, 422)["errors"] != %{}
  end

  defp insert_user do
    user_attrs = %{email: "test@example.com", password_digest: "password"}
    user_changeset = User.changeset(%User{}, user_attrs)
    {:ok, user} = Repo.insert(user_changeset)

    user
  end
end
