class ApplicationController < ActionController::API
  respond_to :json

  before_action :authenticate_user!

  include ActionController::MimeResponds
  include Response

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from NotImplementedError, with: :not_implemented
  rescue_from Pagy::OverflowError, with: :record_error
  rescue_from ArgumentError, with: :record_invalid

  private

  def scope
    @resource ||= class_constant
  end

  def param_scope
    controller_name.singularize
  end

  def class_constant
    @class_constant ||= param_scope.camelize.constantize
  end

  def find_object
    @resource = scope.find_by!(filter_params)
  end

  def filter_params
    params.permit(:id)
  end

  def scope_nested
    obj = request&.path&.split("/")&.delete_if(&:empty?)&.first
    obj = obj&.singularize.capitalize.constantize rescue nil
    obj = obj.find(params[:id]) if obj
  end

  def render_base_error(single_element)
     puts single_element.errors.full_messages
    puts single_element.errors.keys
    render :status => :unprocessable_entity,
            :json => { :success => false,
            :message => "Hay errores que impiden guardar el registro",
            :errors => single_element.errors.full_messages,
            :fields => single_element.errors.keys }
  end

  def render_exception_error(error=nil)
    puts error&.message
    puts error&.backtrace
    render :status => 500,
    :json => {
      :success => false,
      :titulo => "¡Oops! error inesperado.",
      :mensaje => "Ocurrió un error al registrar el servicio.",
      :tipo => "error"
    }
  end

  def record_not_found(e)
    notification_content = {
      message: "El elemento #{e.model} con el id:#{e.id} no existe.",
      title: "No encontramos lo que buscas",
      icon: "fa fa-bell",
      url: "",
      target: ""
    }
    render standard_json_response({}, notification_content, :not_found, [], "")
  end

  def record_invalid(e)
    notification_content = {
      message: e.record.errors.full_messages,
      title: "Registro inválido",
      icon: "fa fa-bell",
      url: "",
      target: ""
    }
    render standard_json_response({}, notification_content, :unprocessable_entity, [], "")
  end

  def record_error(e)
    notification_content = {
      message: e.to_s,
      title: "Error",
      icon: "fa fa-bell",
      url: "",
      target: ""
    }
    render standard_json_response({}, notification_content, :unprocessable_entity, [], "")
  end

  def record_not_unique(e)
    notification_content = {
      message: e.to_s,
      title: "Registro duplicado",
      icon: "fa fa-bell",
      url: "",
      target: ""
    }
    render standard_json_response({}, notification_content, :unprocessable_entity, [], "")
  end

  def not_implemented(e)
    notification_content = {
      message: e.to_s,
      title: "Error en el sistema",
      icon: "fa fa-bell",
      url: "",
      target: ""
    }

    render standard_json_response({}, notification_content, :unprocessable_entity, [], "")
  end

  def user_not_authorized
    notification_content = {
      message: "Usuario no autorizado para ejecutar esta operación",
      title: "Usuario no autorizado",
      icon: "fa fa-bell",
      url: "",
      target: ""
    }
    render standard_json_response({}, notification_content, 403, [], "")
  end

  def standard_json_response(json_data, notification_content, code, errors, backtrace)
    {
      json: {
        data: json_data,
        type: param_scope,
        notification: {
          content: notification_content
        },
        errors: errors,
        backtrace_error: backtrace
      },
      status: code
    }
  end

  def per_page_params
    params[:per_page] || 10
  end

  def record_invalid_error(e)
    notification_content = generate_notification("Hay errores que impiden realizar el registro",
                                                 e.record.errors.full_messages, "fa fa-bell", "", "")
    render standard_json_response({}, notification_content, :unprocessable_entity, [], "")
  end

  def generate_notification(title, message, icon, url, target)
    {
      title: title,
      message: message,
      icon: icon,
      url: url,
      target: target
    }
  end
end
