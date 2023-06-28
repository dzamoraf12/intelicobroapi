require 'rails_helper'

RSpec.describe "/prospects", type: :request do
  let(:user) { create(:user) }
  let(:token) { get_token(user) }
  let(:valid_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
  let(:valid_attributes) { attributes_for(:prospect) }
  let(:invalid_attributes) { attributes_for(:prospect, :with_invalid_data) }

  describe "GET /index" do
    it "renders a successful response" do
      Prospect.create! valid_attributes
      get prospects_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      prospect = Prospect.create! valid_attributes
      get prospect_url(prospect), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Prospect" do
        expect {
          post prospects_url,
               params: { prospect: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Prospect, :count).by(1)
      end

      it "renders a JSON response with the new prospect" do
        post prospects_url,
             params: { prospect: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Prospect" do
        expect {
          post prospects_url,
               params: { prospect: invalid_attributes }, as: :json
        }.to change(Prospect, :count).by(0)
      end

      it "renders a JSON response with errors for the new prospect" do
        post prospects_url,
             params: { prospect: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { names: "New name", neighborhood: "Las misiones" }
      }

      it "updates the requested prospect" do
        prospect = Prospect.create! valid_attributes
        patch prospect_url(prospect),
              params: { prospect: new_attributes }, headers: valid_headers, as: :json
        prospect.reload
        expect(prospect.names).to eq("New name")
        expect(prospect.neighborhood).to eq("Las misiones")
      end

      it "renders a JSON response with the prospect" do
        prospect = Prospect.create! valid_attributes
        patch prospect_url(prospect),
              params: { prospect: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "attaches the uploaded picture" do
        file = fixture_file_upload(Rails.root.join("spec", "support", "fixtures", "logo-web.png"), "image/png")
        prospect = Prospect.create! valid_attributes
        expect {
          patch prospect_url(prospect),
                params: { prospect: { picture: file } }, headers: valid_headers
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it "attaches the uploaded ID front" do
        file = fixture_file_upload(Rails.root.join("spec", "support", "fixtures", "logo-web.png"), "image/png")
        prospect = Prospect.create! valid_attributes
        expect {
          patch prospect_url(prospect),
                params: { prospect: { ID_front: file } }, headers: valid_headers
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it "attaches the uploaded ID back" do
        file = fixture_file_upload(Rails.root.join("spec", "support", "fixtures", "logo-web.png"), "image/png")
        prospect = Prospect.create! valid_attributes
        expect {
          patch prospect_url(prospect),
                params: { prospect: { ID_back: file } }, headers: valid_headers
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it "attaches the uploaded address proof" do
        file = fixture_file_upload(Rails.root.join("spec", "support", "fixtures", "logo-web.png"), "image/png")
        prospect = Prospect.create! valid_attributes
        expect {
          patch prospect_url(prospect),
                params: { prospect: { address_proof: file } }, headers: valid_headers
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the prospect" do
        prospect = Prospect.create! valid_attributes
        patch prospect_url(prospect),
              params: { prospect: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid credentials" do
      it "renders a JSON response with errors for the prospect" do
        prospect = Prospect.create! valid_attributes
        patch prospect_url(prospect),
              params: { prospect: invalid_attributes }, headers: {}, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested prospect" do
      prospect = Prospect.create! valid_attributes
      expect {
        delete prospect_url(prospect), headers: valid_headers, as: :json
      }.to change(Prospect, :count).by(-1)
    end
  end
end
