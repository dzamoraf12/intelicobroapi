# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    raise ActiveRecord::RecordInvalid, resource
  end

  def register_success
    notification_content = generate_notification("Registrado exitosamente.",
                                                 "Ahora ya puedes disfrutar.",
                                                 "fa fa-bell", "", "")
    render standard_json_response(current_user, notification_content, :ok, [], "")
  end
end
