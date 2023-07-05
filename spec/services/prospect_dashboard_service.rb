require 'rails_helper'

RSpec.describe ProspectDashboardService do
  describe "#generate_metrics" do
    let!(:agent1) { create(:agent) }
    let!(:agent2) { create(:agent) }
    let!(:prospects_to_verify_a1) { create_list(:prospect, 2, agent: agent1, verification_status: "pending") }
    let!(:verified_prospects_a1) { create_list(:prospect, 3, agent: agent1, verification_status: "verified") }
    let!(:accepted_prospects_a1) { create_list(:prospect, 1, agent: agent1, verification_status: "accepted") }
    let!(:rejected_prospects_a1) { create_list(:prospect, 1, agent: agent1, verification_status: "rejected") }
    let!(:prospects_to_verify_a2) { create_list(:prospect, 1, agent: agent2, verification_status: "pending") }
    let!(:verified_prospects_a2) { create_list(:prospect, 2, agent: agent2, verification_status: "verified") }
    let!(:accepted_prospects_a2) { create_list(:prospect, 3, agent: agent2, verification_status: "accepted") }
    let!(:rejected_prospects_a2) { create_list(:prospect, 0, agent: agent2, verification_status: "rejected") }

    it "generates the metrics correctly by agent" do
      result = described_class.new(Prospect.by_agent(agent2.id)).generate_metrics
      expect(result).to eq(
        [
          { "text": "Prospectos por verificar", "value": 1, "redirect_to": "appPage" },
          { "text": "Prospectos verificados", "value": 2, "redirect_to": "appPage" },
          { "text": "Prospectos aceptados", "value": 3, "redirect_to": "appPage" },
          { "text": "Prospectos rechazados", "value": 0, "redirect_to": "appPage" }
        ]
      )
    end

    it "generates the metrics correctly all agents" do
      result = described_class.new(Prospect).generate_metrics
      expect(result).to eq(
        [
          { "text": "Prospectos por verificar", "value": 3, "redirect_to": "appPage" },
          { "text": "Prospectos verificados", "value": 5, "redirect_to": "appPage" },
          { "text": "Prospectos aceptados", "value": 4, "redirect_to": "appPage" },
          { "text": "Prospectos rechazados", "value": 1, "redirect_to": "appPage" }
        ]
      )
    end
  end
end
