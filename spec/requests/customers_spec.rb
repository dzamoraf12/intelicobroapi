require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let(:user) { create(:user) }
  let(:valid_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
  let(:valid_attributes) { attributes_for(:customer) }

  describe "GET /index" do
    it "renders a successful response" do
      Customer.create! valid_attributes
      get customers_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      customer = Customer.create! valid_attributes
      get customer_url(customer), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end
end
