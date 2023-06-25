require 'rails_helper'

RSpec.describe Customer, type: :model do
  # describe "validations" do
  # end

  # describe "associations" do
  #   it { should belong_to(:agent).without_validating_presence.
  #                                 with_foreign_key("verification_agent_id") }
  # end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:customer)).to be_valid
    end
  end

  context "scopes" do    
    describe ".by_name" do
      before do
        Customer.all.delete_all
      end

      let!(:customers) { create_list(:customer, 2, name: "Daniel") }

      it "returns customers of given name" do
        result = described_class.by_name("Daniel")
        expect(result).to match_array([
          have_attributes(name: "Daniel"),
          have_attributes(name: "Daniel")
        ])
      end
    end
  end
end
