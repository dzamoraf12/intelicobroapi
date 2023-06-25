class ProspectsController < ApplicationController
  before_action :set_prospect, only: %i[ show update destroy ]

  def index
    render standard_json_response(serializer(filter_list), {}, :ok, [], "")
  end

  def create
    @prospect = Prospect.create!(prospect_params)
    render standard_json_response(serializer(@prospect), {}, :created, [], "")
  end

  def show
    render standard_json_response(serializer(@prospect), {}, :ok, [], "")
  end

  def update
    @prospect.update!(prospect_params)
    render standard_json_response(serializer(@prospect), {}, :ok, [], "")
  end

  def destroy
    @prospect.destroy
    render standard_json_response({}, {}, :no_content, [], "")
  end

  private
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    def prospect_params
      params.require(:prospect).permit(:names, :mother_surname, :father_surname, :street,
                                       :internal_number, :external_number, :zip_code, :neighborhood,
                                       :municipality, :city, :state, :verification_status,
                                       :verified_at, :verification_accepted_at, :latitude, :longitude,
                                       :verification_rejected_at, :agent_id)
    end

    def filter_list
      filters = {
        name: params[:name],
        verification_status: params[:verification_status],
        agent_id: params[:agent_id]
      }
      paginate Prospect.filter(filters), per_page: per_page_params
    end
  
    def serializer(resources, view: nil)
      ProspectSerializer.render_as_hash(resources, view: view)
    end
end
