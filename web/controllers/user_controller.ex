defmodule Rumble.UserController do
  use Rumble.Web, :controller

  def index(conn, _params) do
    users = Repo.all(Rumble.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Rumble.User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    user = Rumble.User.changeset(%Rumble.User{})
    render conn, "new.html", user: user
  end

  def create(conn, %{"user" => user_params}) do
    changeset = Rumble.User.changeset(%Rumble.User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", user: changeset
    end
  end
end
