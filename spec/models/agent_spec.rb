require 'rails_helper'

RSpec.describe Agent, type: :model do
  describe "associations" do
    it { should have_one(:user) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:agent)).to be_valid
    end
  end
end
