require 'rails_helper'

RSpec.describe "/visits", type: :request do
  let(:user) { create(:user) }
  let(:valid_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
  let(:valid_attributes) { attributes_for(:visit) }
  let(:invalid_attributes) { attributes_for(:visit, :with_invalid_data) }

  describe "GET /index" do
    it "renders a successful response" do
      Visit.create! valid_attributes
      get visits_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      visit = Visit.create! valid_attributes
      get visit_url(visit), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Visit" do
        expect {
          post visits_url,
               params: { visit: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Visit, :count).by(1)
      end

      it "renders a JSON response with the new visit" do
        post visits_url,
             params: { visit: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Visit" do
        expect {
          post visits_url,
               params: { visit: invalid_attributes }, as: :json
        }.to change(Visit, :count).by(0)
      end

      it "renders a JSON response with errors for the new visit" do
        post visits_url,
             params: { visit: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { penalty_amount: 100.55 }
      }

      it "updates the requested visit" do
        visit = Visit.create! valid_attributes
        patch visit_url(visit),
              params: { visit: new_attributes }, headers: valid_headers, as: :json
        visit.reload
        expect(visit.penalty_amount).to eq(100.55)
      end

      it "renders a JSON response with the visit" do
        visit = Visit.create! valid_attributes
        patch visit_url(visit),
              params: { visit: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the visit" do
        visit = Visit.create! valid_attributes
        patch visit_url(visit),
              params: { visit: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid credentials" do
      it "renders a JSON response with errors for the visit" do
        visit = Visit.create! valid_attributes
        patch visit_url(visit),
              params: { visit: invalid_attributes }, headers: {}, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested visit" do
      visit = Visit.create! valid_attributes
      expect {
        delete visit_url(visit), headers: valid_headers, as: :json
      }.to change(Visit, :count).by(-1)
    end
  end
end
