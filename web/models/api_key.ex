defmodule BudjetApi.ApiKey do
  use BudjetApi.Web, :model

  schema "api_keys" do
    field :expires_at, Ecto.DateTime
    field :secret, :string
    belongs_to :user, BudjetApi.User

    timestamps
  end

  @required_fields ~w(user_id expires_at secret)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> put_change(:secret, )
  end

  def create_token_for_user(user) do
    token = some_random_string
    secret = hashed_value(token)
    %ApiKey{}
    |> changeset(%{expires_at: 10.hours.from_now, secret: secret, user_id: user.id})
    |> Repo.insert!
    token
  end
end
