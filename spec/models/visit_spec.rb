require 'rails_helper'

RSpec.describe Visit, type: :model do
  subject { create(:visit) }

  describe "validations" do
    it { should validate_presence_of(:penalty_amount) }
    it { should validate_numericality_of(:penalty_amount).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:comments) }
    it { should allow_value(nil).for(:latitude) }
    it { should allow_value("").for(:latitude) }
    it { should allow_value(nil).for(:longitude) }
    it { should allow_value("").for(:longitude) }
    it { should_not allow_value("InvalidLat").for(:latitude) }
    it { should_not allow_value("InvalidLong").for(:longitude) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:customer) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end
end
