# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  private

  def respond_with(_resource, _opts = {})
    avatar_url = current_user.avatar_url unless current_user.nil?
    status = current_user.nil? ? :unauthorized : :ok
    notification_content = generate_notification("Iniciaste sesión.",
                                                 ["Ahora ya puedes disfrutar."],
                                                 [],
                                                 "fa fa-bell", "", "")
    render standard_json_response({ user: current_user, avatar: avatar_url },
                                  notification_content, status, [], "")
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    notification_content = generate_notification("Cerraste sesión.",
                                                 "Nos vemos pronto.",
                                                 "fa fa-bell", "", "")
    render standard_json_response({}, notification_content, :ok, [], "")
  end

  def log_out_failure
    notification_content = generate_notification("No se pudo cerrar sesión.",
                                                 "Error al cerrar la sesión (No se encontró el token).",
                                                 "fa fa-bell", "", "")
    render standard_json_response({}, notification_content, :unauthorized, [], "")
  end
end
