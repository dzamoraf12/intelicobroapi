# app/controllers/members_controller.rb
class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = get_user_from_token
    render json: {
      message: "If you see this, you're in!",
      user: user
    }
  end

  def update_personal_data
    user = get_user_from_token
    user.update!(member_params)

    render json: {
      message: "Datos actualizados"
    }
  end

  def update_avatar
    begin
      file = IdeallFile.new(uploader_params)
      if file.load_to_record
        stored_file, position = file.get_stored_file
        render status: 200,
          json: {
            success: true,
            mensaje: "Archivo cargado",
            avatar_url: file.get_url,
            key: stored_file.blob_id,
            errores: [],
            position: position
          }
      else
        render status: :unprocessable_entity,
          json: {
            success: false,
            mensaje: "No fue posible cargar el archivo",
            base64_image: "",
            errores: []
          }
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace
      render status: 500,
        json: {
          success: false,
          mensaje: "Ocurrió un error inesperado al cargar el archivo",
          errores: [e.message]
        }
    end
  end

  private

  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end

  def member_params
    params.require(:member).permit(:name, :lastname, :cellphone)
  end

  def uploader_params
    # {
    #   parent_class: "Product",
    #   record_id: 1,
    #   parent_attr_file: "images",
    #   path: Rails.root.join("tmp/avatar.jpg").to_s,
    #   filename: "avatar.jpg",
    #   content_type: "image/jpg"
    # }
    # params.require(:file_uploader).permit(:parent_class, :record_id, :parent_attr_file, :path, :filename, :content_type)
    {
      parent_class: "User",
      record_id: current_user.id,
      parent_attr_file: "avatar",
      path: params[:file].tempfile.path,
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      forced_position: params[:position]
    }
  end
end
