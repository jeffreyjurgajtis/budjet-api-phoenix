defmodule BudjetApi.Router do
  use BudjetApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BudjetApi do
    # pipe_through :browser # Use the default browser stack
    pipe_through :api

    get "/", PageController, :index

    resources "/users", UserController, except: [:new, :edit]
    resources "/budget_sheets", BudgetSheetController, except: [:new, :edit, :update]
    resources "/sessions", SessionController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BudjetApi do
  #   pipe_through :api
  # end
end
