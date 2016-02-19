defmodule BudjetApi.SessionController do
  use BudjetApi.Web, :controller

  alias BudjetApi.User
  alias BudjetApi.Repo

  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => %{"email" => email, "password" => _password}}) do
    user = Repo.get_by(User, email: email)

    case user do
      %User{} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user, token: token)
      nil ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end
end
