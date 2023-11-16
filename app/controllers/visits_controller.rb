class VisitsController < ApplicationController
  before_action :set_visit, only: %i[ show update destroy ]

  # GET /visits
  def index
    render standard_json_response(serializer(filter_list), {}, :ok, [], "")
  end

  # GET /visits/1
  def show
    render standard_json_response(serializer(@visit), {}, :ok, [], "")
  end

  # POST /visits
  def create
    @visit = Visit.create!(visit_params)
    render standard_json_response(serializer(@visit), {}, :created, [], "")
  end

  # PATCH/PUT /visits/1
  def update
    @visit.update!(visit_update_params)
    render standard_json_response(serializer(@visit), {}, :ok, [], "")
  end

  # DELETE /visits/1
  def destroy
    @visit.destroy
    render standard_json_response({}, {}, :no_content, [], "")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visit_params
      permitted_params = params.require(:visit).permit(:penalty_amount, :comments, :latitude, :longitude, :user_id, :customer_id)
      permitted_params[:user_id] = current_user.id if current_user

      permitted_params
    end

    def visit_update_params
      params.require(:visit).permit(:penalty_amount, :status)
    end

    def filter_list
      filters = {
        customer_id: params[:customer_id],
        user_id: params[:user_id],
        status: params[:status]
      }
      paginate Visit.filter(filters), per_page: per_page_params
    end

    def serializer(resources, view: nil)
      VisitSerializer.render_as_hash(resources, view: view)
    end
end
