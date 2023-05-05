class RestaurantsController < ApplicationController
  before_action :find_object, only: %i[show update_logo]
  before_action :scope, only: %i[index]
  before_action :filter_list, only: %i[index]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @resource = paginate @resource, per_page: per_page_params

    render standard_json_response(serializer, {}, 200, [], "")
  end

  def show
    render standard_json_response(serializer, {}, 200, [], "")
  end

  def update_logo
    file = IdeallFile.new(update_logo_params)
    file.load_to_record
    
    render standard_json_response(serializer, {}, :ok, [], "")
  end

  private

  def serializer(view: nil)
    @serializer ||= RestaurantSerializer.render_as_hash(@resource, view: view)
  end

  def filter_list
    return @resource = scope.all unless params[:filter].present?

    @resource = filter_and_sort
  end

  def filter_and_sort
    scope.joins(:restaurant_types).where("tipos_restaurant.tipo like :filter ", filter: "%#{params[:filter]}%" )
  end

  def update_logo_params
    {
      parent_class: "Restaurant",
      record_id: @resource.id,
      parent_attr_file: "logo",
      path: params[:file].tempfile.path,
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      forced_position: params[:position]
    }
  end
end
