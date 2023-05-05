class RestaurantTypesController < ApplicationController
  before_action :find_object, only: %i[update_icon update_picture]
  before_action :scope, only: %i[actives index]
  skip_before_action :authenticate_user!, only: %i[actives]
  before_action :include_relanshionship, only: %i[index actives]

  def index
    @resource = paginate @resource, per_page: per_page_params

    render standard_json_response(serializer, {}, 200, [], "")
  end

  def actives
    @resource = paginate @resource.actives, per_page: per_page_params

    render standard_json_response(serializer, {}, 200, [], "")
  end

  def update_icon
    load_asset("icon")
  end

  def update_picture
    load_asset("picture")
  end

  private

  def serializer(view: nil)
    @serializer ||= RestaurantTypeSerializer.render_as_hash(@resource, view: view)
  end

  def load_asset(type)
    file = IdeallFile.new(update_image_params(type))
    file.load_to_record
    
    render standard_json_response(serializer, {}, :ok, [], "")
  end

  def update_image_params(type)
    {
      parent_class: "RestaurantType",
      record_id: @resource.id,
      parent_attr_file: type,
      path: params[:file].tempfile.path,
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      forced_position: params[:position]
    }
  end

  def include_relanshionship
    @resource = @resource.
                  with_attached_icon.
                  with_attached_picture
  end
end
