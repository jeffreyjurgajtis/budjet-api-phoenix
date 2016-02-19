defmodule BudjetApi.BudgetSheetController do
  use BudjetApi.Web, :controller

  alias BudjetApi.BudgetSheet

  plug :scrub_params, "budget_sheet" when action in [:create, :update]

  def index(conn, _params) do
    budget_sheets = Repo.all(BudgetSheet)
    render(conn, "index.json", budget_sheets: budget_sheets)
  end

  def create(conn, %{"budget_sheet" => budget_sheet_params}) do
    changeset = BudgetSheet.changeset(%BudgetSheet{}, budget_sheet_params)

    case Repo.insert(changeset) do
      {:ok, budget_sheet} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", budget_sheet_path(conn, :show, budget_sheet))
        |> render("show.json", budget_sheet: budget_sheet)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BudjetApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    budget_sheet = Repo.get!(BudgetSheet, id)
    render(conn, "show.json", budget_sheet: budget_sheet)
  end

  def update(conn, %{"id" => id, "budget_sheet" => budget_sheet_params}) do
    budget_sheet = Repo.get!(BudgetSheet, id)
    changeset = BudgetSheet.changeset(budget_sheet, budget_sheet_params)

    case Repo.update(changeset) do
      {:ok, budget_sheet} ->
        render(conn, "show.json", budget_sheet: budget_sheet)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BudjetApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    budget_sheet = Repo.get!(BudgetSheet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(budget_sheet)

    send_resp(conn, :no_content, "")
  end
end
