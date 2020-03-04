defmodule ZoneinatorWeb.UserController do
  use ZoneinatorWeb, :controller

  alias ZoneinatorWeb.Authentication
  alias ZoneinatorWeb.UserController.SignUpForm

  def new(conn, _params) do
    changeset = SignUpForm.changeset()
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"sign_up_form" => sign_up_form_params}) do
    case SignUpForm.run(sign_up_form_params) do
      :ok ->
        conn
        |> Authentication.log_in()
        |> put_flash(:info, "Registered successfully")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:new, changeset: changeset)
    end
  end
end
