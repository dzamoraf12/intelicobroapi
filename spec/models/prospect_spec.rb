require 'rails_helper'

RSpec.describe Prospect, type: :model do
  subject { create(:prospect) }

  describe "validations" do
    it {
      should define_enum_for(:verification_status).with_values({
        pending: 0, verified: 1, accepted: 2, rejected: 3
      })
    }
    it { should validate_presence_of(:names) }
    it { should validate_presence_of(:father_surname) }
  end

  describe "conditioned validations" do
    context "attaching picture" do
      before { allow(subject).to receive(:attaching_picture?).and_return(true) }
      it { is_expected.to validate_attached_of(:picture) }
      it { is_expected.to validate_content_type_of(:picture).allowing("image/png", "image/jpeg") }
      it { is_expected.to validate_size_of(:picture).between(1.kilobyte..8.megabytes) }
    end

    context "not attaching picture" do
      before { allow(subject).to receive(:attaching_picture?).and_return(false) }
      it { is_expected.not_to validate_attached_of(:picture) }
    end

    context "attaching ID_front" do
      before { allow(subject).to receive(:attaching_ID_front?).and_return(true) }
      it { is_expected.to validate_attached_of(:ID_front) }
      it { is_expected.to validate_content_type_of(:ID_front).allowing("image/png", "image/jpeg") }
      it { is_expected.to validate_size_of(:ID_front).between(1.kilobyte..8.megabytes) }
    end

    context "not attaching ID_front" do
      before { allow(subject).to receive(:attaching_ID_front?).and_return(false) }
      it { is_expected.not_to validate_attached_of(:ID_front) }
    end

    context "attaching ID_back" do
      before { allow(subject).to receive(:attaching_ID_back?).and_return(true) }
      it { is_expected.to validate_attached_of(:ID_back) }
      it { is_expected.to validate_content_type_of(:ID_back).allowing("image/png", "image/jpeg") }
      it { is_expected.to validate_size_of(:ID_back).between(1.kilobyte..8.megabytes) }
    end

    context "not attaching ID_back" do
      before { allow(subject).to receive(:attaching_ID_back?).and_return(false) }
      it { is_expected.not_to validate_attached_of(:ID_back) }
    end

    context "attaching address_proof" do
      before { allow(subject).to receive(:attaching_address_proof?).and_return(true) }
      it { is_expected.to validate_attached_of(:address_proof) }
      it { is_expected.to validate_content_type_of(:address_proof).allowing("image/png", "image/jpeg") }
      it { is_expected.to validate_size_of(:address_proof).between(1.kilobyte..8.megabytes) }
    end

    context "not attaching address_proof" do
      before { allow(subject).to receive(:attaching_address_proof?).and_return(false) }
      it { is_expected.not_to validate_attached_of(:address_proof) }
    end
  end

  describe "associations" do
    it { should belong_to(:agent).without_validating_presence }
    it { should have_one_attached(:picture) }
    it { should have_one_attached(:ID_front) }
    it { should have_one_attached(:ID_back) }
    it { should have_one_attached(:address_proof) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

  describe "callbacks" do
    it "before update changes status to verified" do
      pending_prospect = create(:prospect, :with_valid_documents)
      expect(pending_prospect.verification_status).to eq("pending")

      pending_prospect.update_attribute(:city, "Obregón")
      pending_prospect.reload
      expect(pending_prospect.verification_status).to eq("verified")
      expect(pending_prospect.verified_at).to be_present
    end
  end

  describe "attach documents" do
    context "with valid documents" do
      let!(:prospect_with_valid_documents) { create(:prospect, :with_valid_documents) }
      it "saves the picture" do
        expect(prospect_with_valid_documents.picture).to be_attached
        expect(prospect_with_valid_documents.picture_url).to be_present
      end
      it "saves the ID front" do
        expect(prospect_with_valid_documents.ID_front).to be_attached
        expect(prospect_with_valid_documents.ID_front_url).to be_present
      end
      it "saves the ID back" do
        expect(prospect_with_valid_documents.ID_back).to be_attached
        expect(prospect_with_valid_documents.ID_back_url).to be_present
      end
      it "saves the address proof" do
        expect(prospect_with_valid_documents.address_proof).to be_attached
        expect(prospect_with_valid_documents.address_proof_url).to be_present
      end
    end

    context "with no documents" do
      let!(:prospect_with_no_documents) { create(:prospect) }
      it "not saves the picture" do
        expect(prospect_with_no_documents.picture).not_to be_attached
        expect(prospect_with_no_documents.picture_url).not_to be_present
      end
      it "not the ID front" do
        expect(prospect_with_no_documents.ID_front).not_to be_attached
        expect(prospect_with_no_documents.ID_front_url).not_to be_present
      end
      it "not the ID back" do
        expect(prospect_with_no_documents.ID_back).not_to be_attached
        expect(prospect_with_no_documents.ID_back_url).not_to be_present
      end
      it "not the address proof" do
        expect(prospect_with_no_documents.address_proof).not_to be_attached
        expect(prospect_with_no_documents.address_proof_url).not_to be_present
      end
    end
  end
end
