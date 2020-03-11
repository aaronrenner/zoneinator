defmodule ZoneinatorWeb.SessionController do
  use ZoneinatorWeb, :controller

  alias ZoneinatorWeb.Authentication
  alias ZoneinatorWeb.SessionController.SignInForm

  def new(conn, _params) do
    changeset = SignInForm.changeset()

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"sign_in_form" => form_params}) do
    case SignInForm.run(form_params) do
      {:ok, user_id} ->
        conn
        |> Authentication.log_in(user_id)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_status(:unauthorized)
        |> put_flash(:error, "Invalid email/password combination.")
        |> render(:new, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
