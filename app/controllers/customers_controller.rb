class CustomersController < ApplicationController
  before_action :set_customer, only: [:show]

  def index
    render standard_json_response(serializer(filter_list), {}, 200, [], "")
  end

  def show
    render standard_json_response(serializer(@customer), {}, :ok, [], "")
  end

  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def filter_list
    filters = { name: params[:name] }
    paginate Customer.filter(filters), per_page: per_page_params
  end

  def serializer(resources, view: nil)
    CustomerSerializer.render_as_hash(resources, view: view)
  end
end
