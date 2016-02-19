defmodule BudjetApi.UserView do
  use BudjetApi.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, BudjetApi.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, BudjetApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      password_digest: user.password_digest}
  end
end
