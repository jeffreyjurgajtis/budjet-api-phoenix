defmodule BudjetApi.PageController do
  use BudjetApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
