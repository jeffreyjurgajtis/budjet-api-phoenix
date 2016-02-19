defmodule BudjetApi.BudgetSheetView do
  use BudjetApi.Web, :view

  def render("index.json", %{budget_sheets: budget_sheets}) do
    %{budget_sheet: render_many(budget_sheets, BudjetApi.BudgetSheetView, "budget_sheet.json")}
  end

  def render("show.json", %{budget_sheet: budget_sheet}) do
    %{budget_sheet: render_one(budget_sheet, BudjetApi.BudgetSheetView, "budget_sheet.json")}
  end

  def render("budget_sheet.json", %{budget_sheet: budget_sheet}) do
    %{id: budget_sheet.id,
      name: budget_sheet.name,
      created_at: budget_sheet.inserted_at,
      links: []
    }
  end
end
