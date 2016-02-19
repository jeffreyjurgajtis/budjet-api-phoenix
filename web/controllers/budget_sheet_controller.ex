defmodule BudjetApi.BudgetSheetController do
  use BudjetApi.Web, :controller

  alias BudjetApi.BudgetSheet
  alias BudjetApi.User
  alias BudjetApi.ChangesetView

  import Ecto.Changeset, only: [put_change: 3]

  plug :scrub_params, "budget_sheet" when action in [:create, :update]

  def index(conn, _params) do
    budget_sheets = Repo.all(BudgetSheet)
    render(conn, "index.json", budget_sheets: budget_sheets)
  end

  def show(conn, %{"id" => id}) do
    budget_sheet = Repo.get!(BudgetSheet, id)
    render(conn, "show.json", budget_sheet: budget_sheet)
  end

  def create(conn, %{"budget_sheet" => budget_sheet_params}) do
    user = Repo.one(User)

    changeset = %BudgetSheet{}
    |> BudgetSheet.changeset(budget_sheet_params)
    |> put_change(:user_id, user.id)

    case Repo.insert(changeset) do
      {:ok, budget_sheet} ->
        conn
        |> put_status(:created)
        |> render("show.json", budget_sheet: budget_sheet)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(BudgetSheet, id)
    |> Repo.delete!

    send_resp(conn, :no_content, "")
  end
end
