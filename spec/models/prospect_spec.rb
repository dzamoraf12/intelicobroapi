require 'rails_helper'

RSpec.describe Prospect, type: :model do
  describe "validations" do
    it {
      should define_enum_for(:verification_status).with_values({
        pending: 0, verified: 1, accepted: 2, rejected: 3
      })
    }
    it { should validate_presence_of(:names) }
    it { should validate_presence_of(:father_surname) }
  end

  describe "associations" do
    it { should belong_to(:agent).without_validating_presence }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:prospect)).to be_valid
    end
  end
end
