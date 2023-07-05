class ProspectsController < ApplicationController
  before_action :set_prospect, only: %i[ show update destroy upload_document ]

  def index
    render standard_json_response(serializer(filter_list), {}, :ok, [], "")
  end

  def dashboard
    render standard_json_response(filter_dashboard, {}, :ok, [], "")
  end

  def create
    @prospect = Prospect.create!(prospect_params)
    render standard_json_response(serializer(@prospect), {}, :created, [], "")
  end

  def show
    render standard_json_response(serializer(@prospect), {}, :ok, [], "")
  end

  def update
    set_attaching_type
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
                                       :verification_rejected_at, :agent_id, :picture, :ID_front,
                                       :ID_back, :address_proof)
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

    def set_attaching_type
      @prospect.attaching_documents = []
      @prospect.attaching_documents << "picture" if prospect_params.key? :picture
      @prospect.attaching_documents << "ID_front" if prospect_params.key? :ID_front
      @prospect.attaching_documents << "ID_back" if prospect_params.key? :ID_back
      @prospect.attaching_documents << "address_proof" if prospect_params.key? :address_proof
    end

    def filter_dashboard
      prospects = Prospect.filter(params)
      Prospect.dashboard_data(prospects)
    end
end
