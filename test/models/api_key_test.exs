defmodule BudjetApi.ApiKeyTest do
  use BudjetApi.ModelCase

  alias BudjetApi.ApiKey

  @valid_attrs %{expires_at: "2010-04-17 14:00:00", secret: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ApiKey.changeset(%ApiKey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ApiKey.changeset(%ApiKey{}, @invalid_attrs)
    refute changeset.valid?
  end
end
