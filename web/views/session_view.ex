defmodule BudjetApi.SessionView do
  use BudjetApi.Web, :view

  def render("show.json", %{user: user}) do
    %{user: %{email: user.email, token: "token"}}
  end

  def render("error.json", %{}) do
    %{errors: "Invalid email/password"}
  end
end
