require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { create(:user) }
    before { allow(subject).to receive(:reset_password_in_process?).and_return(false) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:lastname) }
  end

  describe "associations" do
    it { should belong_to(:agent) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
  end
end